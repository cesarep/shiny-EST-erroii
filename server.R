library(shiny)

shinyServer(function(input, output) {
   output$plot <- renderPlot({
      u = input$ureal
      u0 = input$uzero
      s = input$desv
      intv = c(min(u, u0) - 4*s, max(u, u0) + 4*s)
      curve(dnorm(x, u0, s), intv[1], intv[2], n = 600, asp=15*s, yaxt='n', xlab=quote(x), ylab = quote(P(x)))
      curve(dnorm(x, u, s), intv[1], intv[2], n = 600, yaxt='n', add=T)
      axis(2, 0:2/5)
      conf <- as.double(input$conf) 
      h1 <- input$h1
      
      switch(h1,
             'a' = {
                lim <- c(qnorm(conf/2, u, s), qnorm(1-conf/2, u, s))
                P <- pnorm(lim[2], u0, s) - pnorm(lim[1], u0, s)
                area <- curve(dnorm(x, u0, s), lim[1], lim[2], add = T, yaxt='n')
                alt <- c(dnorm(qnorm(conf/2, u, s), u, s), 0)
                lines(c(lim[-1], lim[-1]), alt, lty=2)
                lines(c(lim[-2], lim[-2]), alt, lty=2)
             },
             'b' = {
                lim <- qnorm(1-conf, u, s)
                P <- pnorm(lim, u0, s) - pnorm(-Inf, u0, s)
                area <- curve(dnorm(x, u0, s), intv[1], lim, add = T, yaxt='n')
                alt <- c(dnorm(lim, u, s), 0)
                lines(c(lim, lim), alt, lty=2)
             },
             'c' = {
                lim <- qnorm(conf, u, s)
                P <- pnorm(Inf, u0, s) - pnorm(lim, u0, s)
                area <- curve(dnorm(x, u0, s), lim, intv[2], add = T, yaxt='n')
                alt <- c(dnorm(lim, u, s), 0)
                lines(c(lim, lim), alt, lty=2)
             }
      )
      
      polygon(c(area$x[1], area$x, area$x[101]), c(0, area$y, 0), col='skyblue', lty=2)
      curve(dnorm(x, u0, s), intv[1], intv[2], n = 600, add=T, lwd=2, col='red', yaxt='n')
      curve(dnorm(x, u, s), intv[1], intv[2], n = 600, add=T, lwd=2, yaxt='n')
      
      output$valor <- renderUI(
         withMathJax(sprintf('$$\\beta=P(Erro\\:tipo\\:II)=%.4f$$', P))
      )
   })
})

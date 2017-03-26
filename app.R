# Student Loan Calculator
# Ashwin Sundar
# March 18 2017
#
# This app gets a student loan, the interest rate on that loan, how soon you want to pay it off, and then tells you how much to pay each month so you can do that. Should also let you enter how much you want to pay per month, and see how long it takes to pay off your loan. It would also be cool to plot everything as well. 
# There are diminishing returns to paying off your loans faster. I need to plot a zero-sum curve that will show what happens if I take the money I would normally put into student loans and put it towards a moderate growth 401k, for example. Or in VBIAX. 
#
# Issues
# 1) This REALLY does not handle multiple loans very well. It might be better to simplify it down (after committing to github!) to just one big consolidated loan. Will make it a LOT more user friendly too. Reduce 80% of the hassle (entering all your loans) and only lose 20% of the functionality (multiple loan entry). Could maybe make a quick calculator to help users calculate their average interest rate
# Updates:
# 1) Add ability to input info for up to 10 different loans
# 2) About/FAQ below plot: Q: Why am I not saving very much, even though I doubled my monthly payments? A: There are diminishing returns for paying off your loans more quickly, because the interest isn't accruing by enough to make the extra payments worthwhile. Paying off a 10000 loan at 5% interest in 2 years versus 4 years only saves you x dollars, but it wraps up twice as much of your money during those initial two years. What if you took that money and invested it instead? Of course, at some point you really need to pay off your loans otherwise the compounding interest starts to pile up. 
# 3) Explain the math in the About section
# 4) Checkboxes to turn on/off different plots
# 5) Disclaimer: This is merely a tool. This does not constitute financial advice. Use at your own risk. Feel free to contact me with any concerns or bugs you have found.
# 6) View source code - link to github
# To deploy app to ashwinsundar.shinyapps.io 
# > rsconnect::deployApp('C:/Users/Ashwin/Dropbox/Side Projects/Student_Loan_Calculator')

require(shiny)
require(plotly)

# Define UI for application
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Student Loan Payoff versus Investment Calculator"),
  
  # Sidebar with nested sidebar panels containing numeric inputs to enter info about each loan.
  sidebarLayout(
    
    sidebarPanel(width = '3',
                 
                 #### #### #### #### ####
                 #### Investment Info ###
                 #### #### #### #### ####
                 numericInput("extraCash",
                              "How much money do you plan to invest each month?",
                              min = 0,
                              max = Inf,
                              value = 250,
                              step = 5),
                 
                 numericInput("investRate",
                              "What is your anticipated return on your investments?",
                              min = 0,
                              max = 25.00,
                              value = 6.1, # VBIAX return rate since inception (year 2000)
                              step = 0.1),
                 
                 #### #### #### #### ####
                 #### Loan Info #### ####
                 #### #### #### #### ####
                 numericInput("numStuLoan",
                              "How many student loans do you have?",
                              min = 0,
                              max = 5,
                              value = 1,
                              step = 1),
                 HTML("<br>"),
                 
                 #### #### #### #### ####
                 #### Loan 1 ## #### ####
                 #### #### #### #### ####
                 conditionalPanel(condition="input.numStuLoan > 0",
                                  HTML("<div align = 'left'><font size = '4'><b>1st Loan</b></font></div>"),
                                  numericInput("loanPrin1",
                                               "Principal",
                                               min = 0,
                                               max = Inf,
                                               value = 10000,
                                               step = 50),
                                  
                                  numericInput("loanInt1",
                                               "Interest Rate",
                                               min = 0.00,
                                               max = 20.00,
                                               value = 5.29,
                                               step = 0.1),
                                  
                                  numericInput("monthPay1",
                                               "Minimum Payment",
                                               min = 0.00,
                                               max = Inf,
                                               value = 100,
                                               step = 1),
                                  
                                  numericInput("extraPay1",
                                               "How much of your money set aside for investment do you want to use to pay this loan instead?",
                                               min = 0.00,
                                               max = Inf,
                                               value = 0,
                                               step = 5)),
                 HTML("<br>"),
                 
                 #### #### #### #### ####
                 #### Loan 2 ## #### ####
                 #### #### #### #### ####
                 conditionalPanel(condition="input.numStuLoan > 1",
                                  HTML("<div align = 'left'><font size = '4'><b>2nd Loan</b></font></div>"),
                                  numericInput("loanPrin2",
                                               "Principal",
                                               min = 0,
                                               max = Inf,
                                               value = 10000,
                                               step = 50),
                                  
                                  numericInput("loanInt2",
                                               "Interest Rate",
                                               min = 0.00,
                                               max = 20.00,
                                               value = 5.29,
                                               step = 0.1),
                                  
                                  numericInput("monthPay2",
                                               "Minimum Payment",
                                               min = 0.00,
                                               max = Inf,
                                               value = 100,
                                               step = 1),  
                                  
                                  numericInput("extraPay2",
                                               "How much of your money set aside for investment do you want to use to pay this loan instead?",
                                               min = 0.00,
                                               max = Inf,
                                               value = 0,
                                               step = 5),
                                  HTML("<a target='_blank' href='mailto:ashiundar@gmail.com?subject=Student Loan Calculator'>Ashwin Sundar, 2017</a><br>"),
                                  HTML("Like this tool? <a target='_blank' href='https://www.paypal.me/ASundar/5'>Donate $5</a>")
                 ),
                 HTML("<br>"),
                 #### #### #### #### ####
                 #### Loan 3 ## #### ####
                 #### #### #### #### ####
                 conditionalPanel(condition="input.numStuLoan > 2",
                                  HTML("<div align = 'left'><font size = '4'><b>Third Loan</b></font></div>"),
                                  numericInput("loanPrin3",
                                               "Principal",
                                               min = 0,
                                               max = Inf,
                                               value = 10000,
                                               step = 50),
                                  
                                  numericInput("loanInt3",
                                               "Interest Rate",
                                               min = 0.00,
                                               max = 20.00,
                                               value = 5.29,
                                               step = 0.1),
                                  
                                  numericInput("monthPay3",
                                               "Minimum Payment",
                                               min = 0.00,
                                               max = Inf,
                                               value = 100,
                                               step = 1),
                                  
                                  numericInput("extraPay3",
                                               "How much of your money set aside for investment do you want to use to pay this loan instead?",
                                               min = 0.00,
                                               max = Inf,
                                               value = 0,
                                               step = 5)),
                 
                 HTML("<br>"),
                 #### #### #### #### ####
                 #### Loan 4 ## #### ####
                 #### #### #### #### ####
                 conditionalPanel(condition="input.numStuLoan > 3",
                                  HTML("<div align = 'left'><font size = '4'><b>Fourth Loan</b></font></div>"),
                                  numericInput("loanPrin4",
                                               "Principal",
                                               min = 0,
                                               max = Inf,
                                               value = 10000,
                                               step = 50),
                                  
                                  numericInput("loanInt4",
                                               "Interest Rate",
                                               min = 0.00,
                                               max = 20.00,
                                               value = 5.29,
                                               step = 0.1),
                                  
                                  numericInput("monthPay4",
                                               "Minimum Payment",
                                               min = 0.00,
                                               max = Inf,
                                               value = 100,
                                               step = 1),
                                  
                                  numericInput("extraPay4",
                                               "How much of your money set aside for investment do you want to use to pay this loan instead?",
                                               min = 0.00,
                                               max = Inf,
                                               value = 0,
                                               step = 5)),
                 HTML("<br>"),
                 
                 #### #### #### #### ####
                 #### Loan 5 ## #### ####
                 #### #### #### #### ####
                 conditionalPanel(condition="input.numStuLoan > 4",
                                  HTML("<div align = 'left'><font size = '4'><b>Fifth Loan</b></font></div>"),
                                  numericInput("loanPrin5",
                                               "Principal",
                                               min = 0,
                                               max = Inf,
                                               value = 10000,
                                               step = 50),
                                  
                                  numericInput("loanInt5",
                                               "Interest Rate",
                                               min = 0.00,
                                               max = 20.00,
                                               value = 5.29,
                                               step = 0.1),
                                  
                                  numericInput("monthPay5",
                                               "Minimum Payment",
                                               min = 0.00,
                                               max = Inf,
                                               value = 100,
                                               step = 1),
                                  
                                  numericInput("extraPay5",
                                               "How much of your money set aside for investment do you want to use to pay this loan instead?",
                                               min = 0.00,
                                               max = Inf,
                                               value = 0,
                                               step = 5))),
    
    
    # Show a plot of the payoff curve
    mainPanel(
      plotlyOutput("loanPlot"),
      plotlyOutput("investmentPlot")
    )
  )
))

# Define server logic 
server <- shinyServer(function(input, output, session) {

  #### #### #### #### ####
  #### Student Loan # ####
  #### Server Back-end ###
  #### #### #### #### ####
  # The variables inside this block aren't global - I don't know a good way around this, except to copy all the code and just use it again for the Net Worth Server Back-end as well. Oh well :P
  output$loanPlot <- renderPlotly({
    
    # Setup
    firstPrin = input$loanPrin1
    firstMonthPay = input$monthPay1
    secondPrin = input$loanPrin2
    secondMonthPay = input$monthPay2
    thirdPrin = input$loanPrin3
    thirdMonthPay = input$monthPay3
    fourthPrin = input$loanPrin4
    fourthMonthPay = input$monthPay4
    fifthPrin = input$loanPrin5
    fifthMonthPay = input$monthPay5
    
    # What to do when the user changes the number of student loans they have - if you don't reset these, the math gets messed up because these values are kept at the last user input and not 0 by default
    if(input$numStuLoan < 5) {
      updateNumericInput(session, "loanPrin5", value = 0)
      updateNumericInput(session, "monthPay5", value = 0)
      updateNumericInput(session, "extraPay5", value = 0)
    }
    
    if(input$numStuLoan < 4) {
      updateNumericInput(session, "loanPrin4", value = 0)
      updateNumericInput(session, "monthPay4", value = 0)
      updateNumericInput(session, "extraPay4", value = 0)
    }
    
    if(input$numStuLoan < 3) {
      updateNumericInput(session, "loanPrin3", value = 0)
      updateNumericInput(session, "monthPay3", value = 0)
      updateNumericInput(session, "extraPay3", value = 0)
    }
    
    if(input$numStuLoan < 2) {
      updateNumericInput(session, "loanPrin2", value = 0)
      updateNumericInput(session, "monthPay2", value = 0)
      updateNumericInput(session, "extraPay2", value = 0)
    }
    
    if (input$numStuLoan < 1) {
      updateNumericInput(session, "loanPrin1", value = 0)
      updateNumericInput(session, "monthPay1", value = 0)
      updateNumericInput(session, "extraPay1", value = 0)
    }
    
    # Update max value for the "Extra Payment" slots. Looks weird but the math comes out correctly if I do it this way.
    totalExtraPayments = input$extraPay1 + input$extraPay2 + input$extraPay3 + input$extraPay4 + input$extraPay5
    updateNumericInput(session, "extraPay1", max = input$extraCash - totalExtraPayments + input$extraPay1) 
    updateNumericInput(session, "extraPay2", max = input$extraCash - totalExtraPayments + input$extraPay2)
    updateNumericInput(session, "extraPay3", max = input$extraCash - totalExtraPayments + input$extraPay3)
    updateNumericInput(session, "extraPay4", max = input$extraCash - totalExtraPayments + input$extraPay4)
    updateNumericInput(session, "extraPay5", max = input$extraCash - totalExtraPayments + input$extraPay5)
    
    # Calculation for the first month
    totalPrin = firstPrin + secondPrin + thirdPrin + fourthPrin + fifthPrin
    prinArray = array(c(round(totalPrin, 2)))
    monthArray = array(c(1))
    
    # Calculation for the second month
    firstPrinNext = firstPrin*(1+input$loanInt1/100/12) - firstMonthPay - input$extraPay1 # accrue monthly interest, then apply payment
    secondPrinNext = secondPrin*(1+input$loanInt2/100/12) - secondMonthPay - input$extraPay2
    thirdPrinNext = thirdPrin*(1+input$loanInt3/100/12) - thirdMonthPay - input$extraPay3
    fourthPrinNext = fourthPrin*(1+input$loanInt4/100/12) - fourthMonthPay - input$extraPay4
    fifthPrinNext = fifthPrin*(1+input$loanInt5/100/12) - fifthMonthPay - input$extraPay5
    totalPrinNext = firstPrinNext + secondPrinNext + thirdPrinNext + fourthPrinNext + fifthPrinNext
    prinArray = c(prinArray, round(totalPrinNext, 2))
    month = 2 # A counter...otherwise if you don't enter a large enough monthly payment, the while loop will go on forever. 
    monthArray = array(c(monthArray, month)) # remaining months' data
    
    # Calculation for all remaining months, projected for up to 20 years out.
    while(totalPrinNext > 0 & month < 240) {
      firstPrinNext = firstPrinNext*(1+input$loanInt1/100/12) - firstMonthPay - input$extraPay1 # accrue monthly interest, then apply payment
      secondPrinNext = secondPrinNext*(1+input$loanInt2/100/12) - secondMonthPay - input$extraPay2
      thirdPrinNext = thirdPrinNext*(1+input$loanInt3/100/12) - thirdMonthPay - input$extraPay3
      fourthPrinNext = fourthPrinNext*(1+input$loanInt4/100/12) - fourthMonthPay - input$extraPay4
      fifthPrinNext = fifthPrinNext*(1+input$loanInt5/100/12) - fifthMonthPay - input$extraPay5
      
      # If any loan drops below 0, then set it back to zero. Otherwise it becomes an "investment" with a positive return rate, which isn't possible. 
      if (firstPrinNext < 0) { 
        firstPrinNext = 0
      }
      
      if (secondPrinNext < 0) {
        secondPrinNext = 0  
      }
      
      if (thirdPrinNext < 0) {
        thirdPrinNext = 0
      }
      
      if (fourthPrinNext < 0) {
        fourthPrinNext = 0
      }
      
      if (fifthPrinNext < 0) {
        fifthPrinNext = 0
      }
      
      totalPrinNext = firstPrinNext + secondPrinNext + thirdPrinNext + fourthPrinNext + fifthPrinNext
      prinArray = c(prinArray, round(totalPrinNext, 2))
      month = month + 1 # A counter...otherwise if you don't enter a large enough monthly payment, the while loop will go on forever.
      monthArray = array(c(monthArray, month))# remaining months' data
    }

    #### #### #### #### ####
    #### Student Loan Plot #
    #### #### #### #### ####
    studentLoanPlot <- plot_ly(x = ~monthArray,
                               y = ~prinArray,
                               type = "bar") %>% layout(title = "Student Loan Debt",
                                                        xaxis = list(title = "Month",
                                                                     range = c(0, tail(monthArray, n = 1))),
                                                        yaxis = list(title = "-$",
                                                                     range = c(0, totalPrin*1.25)))
  })
  
  #### #### #### #### ####
  #### Net Worth #### ####
  #### Server Back-end ###
  #### #### #### #### ####
  output$investmentPlot <- renderPlotly({
    # have to recalculate all the student loan info again. Fortunately, this doesn't seem to be computationally intensive, at least at the moment. 
    # Setup
    firstPrin = input$loanPrin1
    firstMonthPay = input$monthPay1
    secondPrin = input$loanPrin2
    secondMonthPay = input$monthPay2
    thirdPrin = input$loanPrin3
    thirdMonthPay = input$monthPay3
    fourthPrin = input$loanPrin4
    fourthMonthPay = input$monthPay4
    fifthPrin = input$loanPrin5
    fifthMonthPay = input$monthPay5
    
    # What to do when the user changes the number of student loans they have - if you don't reset these, the math gets messed up because these values are kept at the last user input and not 0 by default
    if(input$numStuLoan < 5) {
      updateNumericInput(session, "loanPrin5", value = 0)
      updateNumericInput(session, "monthPay5", value = 0)
      updateNumericInput(session, "extraPay5", value = 0)
    }
    
    if(input$numStuLoan < 4) {
      updateNumericInput(session, "loanPrin4", value = 0)
      updateNumericInput(session, "monthPay4", value = 0)
      updateNumericInput(session, "extraPay4", value = 0)
    }
    
    if(input$numStuLoan < 3) {
      updateNumericInput(session, "loanPrin3", value = 0)
      updateNumericInput(session, "monthPay3", value = 0)
      updateNumericInput(session, "extraPay3", value = 0)
    }
    
    if(input$numStuLoan < 2) {
      updateNumericInput(session, "loanPrin2", value = 0)
      updateNumericInput(session, "monthPay2", value = 0)
      updateNumericInput(session, "extraPay2", value = 0)
    }
    
    if (input$numStuLoan < 1) {
      updateNumericInput(session, "loanPrin1", value = 0)
      updateNumericInput(session, "monthPay1", value = 0)
      updateNumericInput(session, "extraPay1", value = 0)
    }
    
    # Update max value for the "Extra Payment" slots. Looks weird but the math comes out correctly if I do it this way.
    totalExtraPayments = input$extraPay1 + input$extraPay2 + input$extraPay3 + input$extraPay4 + input$extraPay5
    updateNumericInput(session, "extraPay1", max = input$extraCash - totalExtraPayments + input$extraPay1) 
    updateNumericInput(session, "extraPay2", max = input$extraCash - totalExtraPayments + input$extraPay2)
    updateNumericInput(session, "extraPay3", max = input$extraCash - totalExtraPayments + input$extraPay3)
    updateNumericInput(session, "extraPay4", max = input$extraCash - totalExtraPayments + input$extraPay4)
    updateNumericInput(session, "extraPay5", max = input$extraCash - totalExtraPayments + input$extraPay5)
    
    extraPay1 = input$extraPay1 # local variable so I can modify it as loans drop to zero
    extraPay2 = input$extraPay2
    extraPay3 = input$extraPay3
    extraPay4 = input$extraPay4
    extraPay5 = input$extraPay5
    totalExtraPayments = extraPay1 + extraPay2 + extraPay3 + extraPay4 + extraPay5
    
    # Calculation for the first month
    # Student Loans
    totalPrin = firstPrin + secondPrin + thirdPrin + fourthPrin + fifthPrin
    prinArray = array(c(round(totalPrin, 2))) # formats a number to two decimal places
    monthArray = array(c(1))
    # Investments
    investValue = 0 # start at 0
    investValueArray = array(c(investValue))
    moneyLeftForInvestment = input$extraCash - totalExtraPayments # money left to invest, after sending extra money to loans
    
    # Calculation for the second month
    firstPrinNext = firstPrin*(1+input$loanInt1/100/12) - firstMonthPay # accrue monthly interest, then apply payment
    secondPrinNext = secondPrin*(1+input$loanInt2/100/12) - secondMonthPay
    thirdPrinNext = thirdPrin*(1+input$loanInt3/100/12) - thirdMonthPay
    fourthPrinNext = fourthPrin*(1+input$loanInt4/100/12) - fourthMonthPay
    fifthPrinNext = fifthPrin*(1+input$loanInt5/100/12) - fifthMonthPay
    totalPrinNext = firstPrinNext + secondPrinNext + thirdPrinNext + fourthPrinNext + fifthPrinNext
    prinArray = c(prinArray, round(totalPrinNext, 2))
    month = 2 # A counter...otherwise if you don't enter a large enough monthly payment, the while loop will go on forever. 
    monthArray = array(c(monthArray, month)) # remaining months' data
    # Investments
    investValue = investValue*exp(input$investRate/100/12) + moneyLeftForInvestment # continuously compounding, adding on extra money each month
    investValueArray = c(investValueArray, investValue) # add a new entry
    
    # Calculation for all remaining months, projected for up to 20 years out.
    while(totalPrinNext > 0 & month < 240) {
      firstPrinNext = firstPrinNext*(1+input$loanInt1/100/12) - firstMonthPay # accrue monthly interest, then apply payment
      secondPrinNext = secondPrinNext*(1+input$loanInt2/100/12) - secondMonthPay
      thirdPrinNext = thirdPrinNext*(1+input$loanInt3/100/12) - thirdMonthPay
      fourthPrinNext = fourthPrinNext*(1+input$loanInt4/100/12) - fourthMonthPay
      fifthPrinNext = fifthPrinNext*(1+input$loanInt5/100/12) - fifthMonthPay
      
      # Investments
      totalExtraPayments = extraPay1 + extraPay2 + extraPay3 + extraPay4 + extraPay5
      moneyLeftForInvestment = input$extraCash - totalExtraPayments # money left to invest, after sending extra money to loans
      investValue = investValue*exp(input$investRate/100/12) + moneyLeftForInvestment # continuously compounding, adding on extra money each month
      investValueArray = c(investValueArray, round(investValue, 2)) # add a new entry
      
      # If any loan drops below 0, then set it back to zero. Otherwise it becomes an "investment" with a positive return rate, which isn't possible. 
      if (firstPrinNext < 0) { 
        firstPrinNext = 0
        extraPay1 = 0
      }
      
      if (secondPrinNext < 0) {
        secondPrinNext = 0  
        extraPay2 = 0
      }
      
      if (thirdPrinNext < 0) {
        thirdPrinNext = 0
        extraPay3 = 0
      }
      
      if (fourthPrinNext < 0) {
        fourthPrinNext = 0
        extraPay4 = 0
      }
      
      if (fifthPrinNext < 0) {
        fifthPrinNext = 0
        extraPay5 = 0
      }
      
      totalPrinNext = firstPrinNext + secondPrinNext + thirdPrinNext + fourthPrinNext + fifthPrinNext
      prinArray = c(prinArray, round(totalPrinNext, 2))
      month = month + 1 # A counter...otherwise if you don't enter a large enough monthly payment, the while loop will go on forever.
      monthArray = array(c(monthArray, month))# remaining months' data
    }
    
    #### #### #### #### ####
    #### Investment Plot ###
    #### #### #### #### ####
    investmentPlot <- plot_ly(x = ~monthArray,
                              y = ~investValueArray,
                              type = "bar") %>% layout(title = "Investment Value",
                                                       xaxis = list(title = "Month",
                                                                    range = c(1, tail(monthArray, n = 1))), # tail gets the last element in an array
                                                       yaxis = list(title = "$",
                                                                    range = c(0, 100000)))
    
  })
})

# Run the application 
shinyApp(ui = ui, server = server)


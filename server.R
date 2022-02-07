function(input, output){
  options(scipen = 999)

  
  output$plot1 <- renderPlotly({
    # data untuk plot_case1
    case1 <- nobel_clean %>%
      mutate(year= as.factor(year)) %>% 
      select(year,category,gender,name_of_university,age) %>%
      filter(!is.na(name_of_university), year == input$year) %>%
      group_by(name_of_university) %>%
      summarise(count=n()) %>%
      ungroup() %>%
      arrange(desc(count),name_of_university)
    
    # visualisasi plot2
    plot1 <- ggplot(case1,aes(x=reorder(name_of_university,desc(count)),y=count, fill=name_of_university,text = glue("name_of_university: {count}"))) + geom_bar(stat="identity", width=.5, position = "dodge") +
      labs(title = "Top University With Most Nobel Prizes") +
      xlab('University') +
      ylab("Prizes") +
      theme(legend.position = "none",axis.text.x = element_text(angle = 45, vjust = 0.5, hjust=1))
    
    ggplotly(plot1, tooltip = "text")
    
  })


  
  output$plot2 <- renderPlotly({
    case2 <- nobel_clean %>%
      filter(category == input$category) %>%
      select(category,gender) %>%  
      group_by(gender) %>%
      summarise(n = n()) %>%
      arrange(desc(n))  
    
    # visualisasi untuk plot1
    plot2 <- ggplot(data = case2, mapping = aes(x = n, y = reorder(gender, n),text = glue("gender: {n}"))) +
      geom_col(mapping = aes(fill = gender),position = "dodge")+
      labs(y = "Gender", x = "Prizes", title = "Gender Distribution of Winner Based On Category", 
           subtitle = "")+
      theme_minimal()
    ggplotly(plot2, tooltip = "text")
  })
  
  output$plot3 <- renderPlotly({

    
    # visualisasi plot3
    options(repr.plot.width = 18, repr.plot.height = 9)
    plot3 <- ggplot(nobel_clean, aes(year,age,col=category),text = glue("category: {age}")) +
      geom_point() +
      facet_wrap(~category)+
      geom_smooth()+
      scale_color_manual(values=rainbow(n=6))
    labs(title = 'Age of Nobel Laureates over the years', x = '', y = '') +
      theme(legend.position = "none", panel.spacing.x = unit(2, "lines"))
      
    
    ggplotly(plot3, tooltip = "text")
    
  })
  


  # Data Table
  output$nobel_data<- renderDataTable({
    DT::datatable(data = nobel_clean, 
                  options = list(scrollX = TRUE, scrollY = TRUE))
  })
  
  
  
}
package com.vistaluxhms.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewResolverRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;


@Configuration
public class ViewResolverConfiguration implements WebMvcConfigurer {

  @Autowired
  private ApplicationContext applicationContext;
  
  
  @Override
  public void configureViewResolvers(ViewResolverRegistry registry) {
    InternalResourceViewResolver jspViewResolver = new InternalResourceViewResolver();
    jspViewResolver.setPrefix("/WEB-INF/jsp/");
    jspViewResolver.setSuffix(".jsp");
    jspViewResolver.setViewClass(JstlView.class);
    registry.viewResolver(jspViewResolver);


  }


  
  /*@Override
  public void addResourceHandlers(ResourceHandlerRegistry registry) {
      registry.addResourceHandler("/resources/**")
              .addResourceLocations("classpath:/static/resources/");
  }*/
 

}

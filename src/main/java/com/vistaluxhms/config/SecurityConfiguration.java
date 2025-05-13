package com.vistaluxhms.config;


import com.vistaluxhms.services.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;



@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
    @Autowired
    private UserDetailsServiceImpl myUserDetailsService;


    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(myUserDetailsService);
    }


	/*@Bean
	public PasswordEncoder passwordEncoder() {
		return NoOpPasswordEncoder.getInstance();
	}*/

    @Bean
    public PasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }


    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.csrf().disable()
                .headers()
                .frameOptions().sameOrigin()  // ← ✅ Add this line
                .and()
                .authorizeRequests()
                .antMatchers("/login", "/resources/**", "/static/**").permitAll() // Allow public access to login and resources
                .antMatchers("/admin").hasRole("ADMIN") // Only admins can access /admin
                .antMatchers("/user").hasAnyRole("ADMIN", "USER") // Admins and users can access /user
                .anyRequest().authenticated() // All other requests need authentication
                .and()
                .formLogin()
                .loginPage("/login") // Custom login page
                .permitAll() // Allow everyone to access the login page
                .defaultSuccessUrl("/view_workloadhome", true) // Redirect after successful login
                .and()
                .logout()
                .permitAll(); // Allow logout for everyone
    }
}
package com.elearning.userservice.security.services;

import com.elearning.userservice.model.User;
import com.elearning.userservice.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    UserRepository userRepository;

    @Override
    @Transactional
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User Not Found with username: " + username));

        // This needs a UserDetails implementation (e.g., UserDetailsImpl) that wraps the User entity
        // return UserDetailsImpl.build(user); // Placeholder - UserDetailsImpl needs to be created
        // throw new UnsupportedOperationException("UserDetailsImpl not yet implemented"); // Temporary
        return UserDetailsImpl.build(user); // Now uses the created UserDetailsImpl
    }

} 
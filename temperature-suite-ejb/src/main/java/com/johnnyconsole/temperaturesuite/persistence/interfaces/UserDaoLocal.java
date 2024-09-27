package com.johnnyconsole.temperaturesuite.persistence.interfaces;

import com.johnnyconsole.temperaturesuite.persistence.User;

import javax.ejb.Local;

@Local
public interface UserDaoLocal {

    User getUser(String username);
    boolean userExists(String username);
    boolean addUser(User user);
    boolean removeUser(User user, String myUsername);
    boolean verifyUser(String username, String passwordPlainText);

}

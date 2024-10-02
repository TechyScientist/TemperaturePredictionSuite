package com.johnnyconsole.temperaturesuite.persistence.interfaces;

import com.johnnyconsole.temperaturesuite.persistence.User;

import javax.ejb.Local;
import java.util.List;

@Local
public interface UserDaoLocal {

    User getUser(String username);
    boolean userExists(String username);
    long userCount();
    List getUsersExcept(String username);
    boolean addUser(User user);
    boolean removeUser(User user, String myUsername);
    boolean verifyUser(String username, String passwordPlainText);

}

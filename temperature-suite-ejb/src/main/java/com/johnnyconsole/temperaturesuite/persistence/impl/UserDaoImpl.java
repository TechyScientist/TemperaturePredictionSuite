package com.johnnyconsole.temperaturesuite.persistence.impl;

import at.favre.lib.crypto.bcrypt.BCrypt;
import com.johnnyconsole.temperaturesuite.persistence.User;
import com.johnnyconsole.temperaturesuite.persistence.interfaces.UserDaoLocal;

import javax.ejb.Stateful;
import javax.enterprise.inject.Alternative;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

@Stateful
@Alternative
public class UserDaoImpl implements UserDaoLocal {

    @PersistenceContext(unitName="user")
    private EntityManager manager;

    @Override
    public User getUser(String username) {
        try {
            Query query = manager.createNamedQuery("User.FindByUsername");
            query.setParameter("username", username);
            return (User) query.getSingleResult();
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public boolean userExists(String username) {
        Query query = manager.createNamedQuery("User.FindByUsername");
        query.setParameter("username", username);
        return query.getSingleResult() != null;
    }

    @Override
    public boolean addUser(User user) {
        try {
            manager.persist(user);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean removeUser(User user, String myUsername) {
        try {
            if (user.getUsername().equals(myUsername)) {
                return false;
            }
            manager.remove((manager.contains(user) ? user : manager.merge(user)));
            return true;
        }
        catch (Exception e) {
            return false;
        }
    }

    @Override
    public boolean verifyUser(String username, String passwordPlainText) {
        try {
            User user = getUser(username);
            return BCrypt.verifyer().verify(passwordPlainText.getBytes(),
                    user.getPassword().getBytes()).verified;
        } catch (Exception e) {
            return false;
        }
    }
}

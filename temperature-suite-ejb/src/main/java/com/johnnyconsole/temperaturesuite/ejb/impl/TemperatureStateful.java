package com.johnnyconsole.temperaturesuite.ejb.impl;

import com.johnnyconsole.temperaturesuite.ejb.interfaces.TemperatureStatefulLocal;

import javax.ejb.Stateful;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;

@Stateful
@SessionScoped
public class TemperatureStateful implements TemperatureStatefulLocal, Serializable {

    private String username, name;
    private int accessLevel = -1;

    @Override
    public boolean isLoggedIn() {
        return accessLevel != -1;
    }

    @Override
    public String loggedInUsername() {
        return isLoggedIn() ? username: null;
    }

    @Override
    public String loggedInName() {
        return isLoggedIn() ? name : null;
    }

    @Override
    public int loggedInAccessLevel() {
        return isLoggedIn() ? accessLevel : -1;
    }

    @Override
    public void logIn(String username, String name, int accessLevel) {
        this.username = username;
        this.name = name;
        this.accessLevel = accessLevel;
    }

    @Override
    public void logOut() {
        username = name = null;
        accessLevel =  -1;
    }
}

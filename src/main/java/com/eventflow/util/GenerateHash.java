package com.eventflow.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Temporary utility to generate a BCrypt hash.
 * Run this once then delete it.
 */
public class GenerateHash {

    public static void main(String[] args) {
        String password = "Admin@123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt());
        System.out.println("Hash: " + hash);
    }
}
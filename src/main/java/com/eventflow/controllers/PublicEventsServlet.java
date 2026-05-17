package com.eventflow.controllers;

import com.eventflow.model.EventModel;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/events")
public class PublicEventsServlet extends HttpServlet {

    private final EventModel eventModel = new EventModel();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String filter = req.getParameter("filter");
        String search = req.getParameter("search");

        List<Map<String, Object>> events = eventModel.getPublicEvents(filter, search);
        Map<String, Object> featured    = eventModel.getFeaturedEvent();

        req.setAttribute("events",   events);
        req.setAttribute("featured", featured);
        req.setAttribute("filter",   filter  != null ? filter  : "all");
        req.setAttribute("search",   search  != null ? search  : "");

        req.getRequestDispatcher("/WEB-INF/pages/public/events.jsp").forward(req, res);
    }
}
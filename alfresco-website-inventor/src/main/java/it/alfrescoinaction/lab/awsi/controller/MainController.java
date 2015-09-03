package it.alfrescoinaction.lab.awsi.controller;


import it.alfrescoinaction.lab.awsi.domain.Downloadable;
import it.alfrescoinaction.lab.awsi.domain.WebPage;
import it.alfrescoinaction.lab.awsi.service.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletResponse;
import java.io.IOException;

@Controller
public class MainController {

    @Autowired
    Service service;

    @RequestMapping(value="/", method = RequestMethod.GET)
    public String homepage(Model model) {

        WebPage wp = service.buildWebPage("home");
        model.addAttribute("links", wp.getLinks());
        model.addAttribute("categories", wp.getCategories());
        model.addAttribute("parentPath", wp.getParentId());

        return "page";
    }

    @RequestMapping(value="/p/{id}", method = RequestMethod.GET)
    public String page(Model model, @PathVariable("id") String id) {

        WebPage wp = service.buildWebPage(id);
        model.addAttribute("title",wp.getTitle());
        model.addAttribute("links", wp.getLinks());
        model.addAttribute("categories", wp.getCategories());
        model.addAttribute("contents", wp.getContents());
        model.addAttribute("parentId", wp.getParentId());
        model.addAttribute("specialContent", wp.getSpecialContent());

        return "page";
    }

    @RequestMapping(value = "proxy/{id}", method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<InputStreamResource> get(ServletResponse response, @PathVariable("id") String id) throws IOException {
        Downloadable downloadable = service.getDownloadable(id);

        return ResponseEntity.ok()
            .header("content-disposition", "attachment; filename=\"" + downloadable.getName() + "\"")
            .contentLength(downloadable.getContentLength())
            .contentType(MediaType.parseMediaType(downloadable.getMimeType()))
            .body(new InputStreamResource(downloadable.getStream()));
    }

}

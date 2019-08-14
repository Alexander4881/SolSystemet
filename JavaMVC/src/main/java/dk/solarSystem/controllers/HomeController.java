package dk.solarSystem.controllers;

import dk.solarSystem.model.PersonForm;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;

@Controller
@RequestMapping("/")
public class HomeController {

    @RequestMapping(method = RequestMethod.GET)
    public String helloMessage(ModelMap model){
        // add a string to the model that get sent to the view
        model.addAttribute("variableName", "string content");
        model.addAttribute("title", "Home");
        // view name
        return "Home";
    }

    @RequestMapping(value = "userform", method = RequestMethod.GET)
    public String showForm(PersonForm personForm){
        return "form";
    }

    @RequestMapping(value = "userform", method = RequestMethod.POST)
    public String checkPersonInfo(@Valid PersonForm personForm, BindingResult bindingResult){

        if (bindingResult.hasErrors()){
            return "form";
        }

        return "results";
    }
}



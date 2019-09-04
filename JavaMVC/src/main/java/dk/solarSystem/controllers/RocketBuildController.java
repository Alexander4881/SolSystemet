package dk.solarSystem.controllers;
import dk.solarSystem.model.MySQLAccess;
import dk.solarSystem.model.Planet3DInformation;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import java.util.ArrayList;

@Controller
@RequestMapping("/rocketbuild")
public class RocketBuildController {

    @RequestMapping(method = RequestMethod.GET)
    public String Index(ModelMap model){

        MySQLAccess mySQLAccess = new MySQLAccess();

        model.addAttribute("planets",mySQLAccess.GetAll3DPlanetsInformation());
        model.addAttribute("parts", mySQLAccess.GetRocketParts());

        return "rocketbuild";
    }
}
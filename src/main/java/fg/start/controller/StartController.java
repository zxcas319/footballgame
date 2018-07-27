package fg.start.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import fg.common.utils.Gmailsend;
import fg.start.service.StartService;
import fg.vo.UserVO;

@Controller
public class StartController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "startService")
	private StartService startService;

	@RequestMapping(value = "/start/mainPage.do", method = RequestMethod.POST)
	public ModelAndView mainPage(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("start/mainPage");
		return mv;
	}
	
	@RequestMapping(value = "/start/getTeamInfo.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getTeamInfo(HttpServletRequest req, HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute("userSession");
		String key = user.getUserKey();
		Map<String, Object> result = startService.getTeamInfo(key); // Äõ¸®¹® °á°ú

		return result;
	}

}

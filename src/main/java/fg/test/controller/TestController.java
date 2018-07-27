package fg.test.controller;

import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import fg.login.service.LoginService;
import fg.test.service.TestService;
import fg.vo.UserVO;

@Controller
public class TestController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "testService")
	private TestService testService;
	@Resource(name = "loginService")
	private LoginService loginService;


	@RequestMapping(value = "/test/testPage.do")
	public ModelAndView testPage(HttpServletRequest req, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("test/testPage");
		UserVO user = (UserVO) session.getAttribute("userSession");
		String key = user.getUserKey();
		String define_match_time = req.getParameter("define_match_time");
		String define_tactical_time = req.getParameter("define_tactical_time");
		String define_break_time = req.getParameter("define_break_time");
		
		mv.addObject("key", key);
		mv.addObject("define_match_time", define_match_time);
		mv.addObject("define_tactical_time", define_tactical_time);
		mv.addObject("define_break_time", define_break_time);
		return mv;
	}

	@RequestMapping(value = "/test/testMakeGame.do")
	public ModelAndView testMakeGame(HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("test/testMakeGame");
		String key = req.getParameter("send_key");
		mv.addObject("key", key);
		return mv;
	}
	
	@RequestMapping(value = "/test/testTeamSetting.do")
	public ModelAndView testTeamSetting(HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("test/testTeamSetting");
		String key = req.getParameter("send_key");
		
		List<Map<String, Object>> list = loginService.getPlayerList(key);
		list = testService.getPlayerOverall(list);
		
		mv.addObject("key", key);
		mv.addObject("player_list",list);
		return mv;
	}
	
	@RequestMapping(value = "/test/getPlayerInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getPlayerInfoDetail(HttpServletRequest req) throws Exception {
		String key = req.getParameter("player_key");

		Map<String, Object> result = testService.getPlayerInfoDetail(key);

		return result;
	}
}
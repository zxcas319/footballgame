package fg.manage.controller;

import java.util.ArrayList;
import java.util.HashMap;
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
import fg.manage.service.ManageService;
import fg.vo.UserVO;

@Controller
public class ManageController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "manageService")
	private ManageService manageService;
	@Resource(name = "loginService")
	private LoginService loginService;
	
	@RequestMapping(value = "/manage/teamSetting.do")
	public ModelAndView testTeamSetting(HttpServletRequest req, HttpSession session) throws Exception {
		ModelAndView mv = new ModelAndView("manage/teamSetting");
		UserVO user = (UserVO) session.getAttribute("userSession");
		String key = user.getUserKey();
		
		List<Map<String, Object>> list = loginService.getPlayerList(key);
		list = manageService.getPlayerOverall(list);
		
		mv.addObject("player_list",list);
		return mv;
	}
	
	@RequestMapping(value = "/manage/getPlayerInfoDetail.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getPlayerInfoDetail(HttpServletRequest req) throws Exception {
		String key = req.getParameter("player_key");

		Map<String, Object> result = manageService.getPlayerInfoDetail(key);

		return result;
	}
	
	@RequestMapping(value = "/manage/saveSelectPosition.do", method = RequestMethod.POST)
	public @ResponseBody void saveSelectPosition(HttpServletRequest req) throws Exception {
		String temp_key = req.getParameter("player_key");
		String temp_position = req.getParameter("select_position");

		String[] key = temp_key.split("/");
		String[] position = temp_position.split("/");
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> param;
		for(int i = 0;i < key.length;i++) {
			if(!key.equals("") && key != null) {
				param = new HashMap<String, Object>();
				param.put("key", key[i]);
				param.put("position", position[i]);
				list.add(param);
			}
		}
		manageService.resetSelectPosition();
		manageService.saveSelectPosition(list);
	}
}
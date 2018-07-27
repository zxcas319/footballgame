package fg.transfer.controller;

import java.util.ArrayList;
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
import fg.login.service.LoginService;
import fg.transfer.service.TransferService;
import fg.vo.UserVO;

@Controller
public class TransferController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "loginService")
	private LoginService loginService;

	@Resource(name = "transferService")
	private TransferService transferService;

	@RequestMapping(value = "/transfer/transferPage.do", method = RequestMethod.POST)
	public ModelAndView mainPage(HttpServletRequest req, HttpServletResponse res, HttpSession session)
			throws Exception {
		ModelAndView mv = new ModelAndView("transfer/transferPage");
		UserVO user = (UserVO) session.getAttribute("userSession");
		String key = user.getUserKey();
		int appear = 3;

		transferService.removeTempPlayer();
		transferService.dropTempPlayer(appear);
		transferService.removeTempUserKey(key);
		Map<String, Object> percent = transferService.getRatingInfo(key); // Äõ¸®¹® °á°ú
		List<Map<String, Object>> result = transferService.makePlayer(percent, key);
		mv.addObject("player_list", result);

		return mv;
	}

	@RequestMapping(value = "/transfer/getPlayerInfo.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> getPlayerInfo(HttpServletRequest req) throws Exception {
		String player_key = req.getParameter("send_key");

		Map<String, Object> result = transferService.getPlayerInfo(player_key); // Äõ¸®¹® °á°ú

		return result;
	}

	@RequestMapping(value = "/transfer/insertTransfer.do", method = RequestMethod.POST)
	public @ResponseBody void insertTransfer(HttpServletRequest req, HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute("userSession");
		String player_key = req.getParameter("player_key");
		String team_key = user.getTeamKey();
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("player_key", player_key);
		param.put("team_key", team_key);
		
		transferService.insertTransfer(param);
	}
}

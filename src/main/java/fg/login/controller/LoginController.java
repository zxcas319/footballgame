package fg.login.controller;

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
import fg.vo.UserVO;

@Controller
public class LoginController {
	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "loginService")
	private LoginService loginService;

	@RequestMapping(value = "/login/loginPage.do")
	public ModelAndView loginPage() throws Exception {
		ModelAndView mv = new ModelAndView("/login/loginPage");
		return mv;
	}

	@RequestMapping(value = "/login/signupPage.do")
	public ModelAndView signupPage() throws Exception {
		ModelAndView mv = new ModelAndView("/login/signupPage");
		return mv;
	}

	@RequestMapping(value = "/login/loginAction.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> loginAction(HttpServletRequest req, HttpSession session) throws Exception {
		String id = req.getParameter("send_id");
		String pw = req.getParameter("send_pw");

		Map<String, Object> info = new HashMap<String, Object>();
		info.put("id", id);
		info.put("pw", pw);

		Map<String, Object> result = new HashMap<String, Object>();
		if (id.equals("") || id == null) {
			result.put("error", "Please enter ID.");
			log.debug(" Request login Fail \t:  ID is null");

			return result;
		} else if (pw.equals("") || pw == null) {
			result.put("error", "Please enter PW.");
			log.debug(" Request login Fail \t:  PW is null");

			return result;
		}

		Boolean valid = loginService.checkLoginInfo(info);
		if (valid) {
			UserVO user = loginService.getUserInfo(info);
			session.setAttribute("userSession", user);
			String key = user.getUserKey();
			String created_team = user.getTeamKey();
			result.put("user_key", key);
			result.put("team_key", created_team);

			log.debug(" Request id \t:  " + id);
			log.debug(" Request pw \t:  " + pw);
			log.debug(" Response key \t:  " + key);
			log.debug(" Response team \t:  " + created_team);
		} else {
			result.put("error", "Please check ID or PW.");
			log.debug(" Request login Fail \t:  No Matching Information.");
		}

		return result;
	}

	@SuppressWarnings("unused")
	@RequestMapping(value = "/login/findUserInfo.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> findUserInfo(HttpServletRequest req) throws Exception {
		String email = req.getParameter("send_email");
		String mode = req.getParameter("send_mode");

		Map<String, Object> info = new HashMap<String, Object>();
		info.put("email", email);

		Map<String, Object> result = new HashMap<String, Object>();
		if (mode.equals("pw")) {
			String id = req.getParameter("send_id");
			if (id.equals("") || id == null) {
				result.put("error", "Please enter ID");
				return result;
			} else if (email.equals("") || email == null) {
				result.put("error", "Please enter E-mail");
				return result;
			} else {
				info.put("id", id);
				result = loginService.findUserInfo(info);
				if (result == null) {
					result = new HashMap<String, Object>();
					result.put("error", "No match data");
				}
			}
		} else if (!email.equals("") && email != null) {
			result = loginService.findUserInfo(info);
			if (result == null) {
				result = new HashMap<String, Object>();
				result.put("error", "No match E-mail");
			}
		} else
			result.put("error", "Please enter E-mail");

		return result;
	}

	@RequestMapping(value = "/login/findPage.do")
	public ModelAndView findPage(HttpServletRequest req) throws Exception {
		ModelAndView mv = new ModelAndView("login/findPage");
		String mode = req.getParameter("send_mode");
		mv.addObject("mode", mode);
		return mv;
	}

	@RequestMapping(value = "/login/createTeam.do", method = RequestMethod.POST)
	public ModelAndView createTeam(HttpServletRequest req, HttpServletResponse res) throws Exception {
		ModelAndView mv = new ModelAndView("login/createTeam");
		return mv;
	}

	@RequestMapping(value = "/login/createPlayer.do", method = RequestMethod.POST)
	public @ResponseBody List<Map<String, Object>> createPlayer(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute("userSession");
		String key = user.getUserKey();
		loginService.removePlayerList(key);
		int position = 0;
		int rating = 0;
		Map<String, Object> per = loginService.makePercent(rating);
		for (int i = 0; i < 23; i++) {
			if (i == 3 || i == 11 || i == 19)
				position++;
			loginService.makePlayer(position, rating, key, per);
		}
		List<Map<String, Object>> list = loginService.getPlayerList(key);
		list = loginService.getPlayerOverall(list);
		return list;
	}

	@RequestMapping(value = "/login/editPlayerName.do", method = RequestMethod.POST)
	public @ResponseBody void editPlayerName(HttpServletRequest req, HttpServletResponse res) throws Exception {
		String player_key = req.getParameter("player_key");
		String name = req.getParameter("name");
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", player_key);
		param.put("name", name);
		loginService.editPlayerName(param);
	}

	@RequestMapping(value = "/login/saveTeam.do", method = RequestMethod.POST)
	public @ResponseBody void saveTeam(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute("userSession");
		String key = user.getUserKey();
		String team_name = req.getParameter("team_name");
		String tendency = req.getParameter("tendency");
		String rating = req.getParameter("rating");

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("key", key);
		param.put("team_name", team_name);
		param.put("tendency", Integer.parseInt(tendency));
		param.put("rating", Integer.parseInt(rating));

		loginService.saveTeam(param);
	}

	@RequestMapping(value = "/login/checkId.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkId(HttpServletRequest req) throws Exception {
		String id = req.getParameter("send_id");

		Map<String, Object> result = new HashMap<String, Object>();
		if (id.equals("") || id == null) {
			result.put("error", "Please enter ID.");
			log.debug(" Request login Fail \t:  ID is null");
			return result;
		}

		result = loginService.checkId(id); // 쿼리문 결과

		return result;
	}

	@RequestMapping(value = "/login/checkName.do", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> checkName(HttpServletRequest req) throws Exception {
		String name = req.getParameter("send_name");

		Map<String, Object> result = new HashMap<String, Object>();
		if (name.equals("") || name == null) {
			result.put("error", "Please enter Name.");
			log.debug(" Request login Fail \t:  Name is null");
			return result;
		}

		result = loginService.checkName(name); // 쿼리문 결과

		return result;
	}

	@RequestMapping(value = "/login/authEmail.do", method = RequestMethod.POST)
	public @ResponseBody String authEmail(HttpServletRequest req) throws Exception {
		String auth_num = "";
		String send_email = req.getParameter("send_email");

		Random generator = new Random();
		int string_rand = 0;
		int num_rand = 0;
		for(int i = 0;i < 4;i++) {
			string_rand = generator.nextInt(26) + 65;
			num_rand = generator.nextInt(10) + 48;
			auth_num += Character.toString((char) string_rand);
			auth_num += Character.toString((char) num_rand);
		}
		log.debug(" Send auth number \t:  " + auth_num + " to " + send_email);
		
		Gmailsend mail = new Gmailsend();
		mail.GmailSet(send_email, "FG game auth number.", auth_num);
		
		return auth_num;
	}

	@RequestMapping(value = "/login/signupAction.do", method = RequestMethod.POST)
	public @ResponseBody void signupAction(HttpServletRequest req) throws Exception {
		String id = req.getParameter("send_id");
		String name = req.getParameter("send_name");
		String pw = req.getParameter("send_pw");
		String send_email = req.getParameter("send_email");

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id);
		param.put("name", name);
		param.put("pw", pw);
		param.put("email", send_email);

		loginService.signupAction(param);
	}
}
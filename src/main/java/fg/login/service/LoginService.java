package fg.login.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import fg.vo.UserVO;

@Service
public interface LoginService {
	Boolean checkLoginInfo(Map<String, Object> info) throws Exception;
	UserVO getUserInfo(Map<String, Object> info) throws Exception;
	void makePlayer(int position, int rating, String key, Map<String, Object> per) throws Exception;
	Map<String, Object> makePercent(int rating) throws Exception;
	List<Map<String, Object>> getPlayerList(String key) throws Exception;
	List<Map<String, Object>> getPlayerOverall(List<Map<String, Object>> list) throws Exception;
	void removePlayerList(String key) throws Exception;
	void editPlayerName(Map<String, Object> param) throws Exception;
	void saveTeam(Map<String, Object> param) throws Exception;
	Map<String, Object> findUserInfo(Map<String, Object> info) throws Exception;
	Map<String, Object> checkId(String id) throws Exception;
	void signupAction(Map<String, Object> param) throws Exception;
	Map<String, Object> checkName(String name) throws Exception;
}
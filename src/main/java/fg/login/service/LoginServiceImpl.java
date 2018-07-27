package fg.login.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import fg.login.dao.LoginDAO;
import fg.vo.UserVO;

@Service("loginService")
public class LoginServiceImpl implements LoginService{
	@Resource(name="loginDAO")
    private LoginDAO loginDAO;
	Logger log = Logger.getLogger(this.getClass());

	public Boolean checkLoginInfo(Map<String, Object> info) {
		String user_key = null;
		
		user_key = loginDAO.getUserKey(info);
		
		if(user_key != null)
			return true;
		else
			return false;
	}

	@Override
	public UserVO getUserInfo(Map<String, Object> info) throws Exception {
		UserVO result = loginDAO.getUserInfo(info);
		return result;
	}
	@Override
	public Map<String, Object> makePercent(int rating) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rating", rating);
		Map<String, Object> per = loginDAO.getMakePercent(map);
		
		return per;
	}

	@Override
	public void makePlayer(int position, int rating, String key, Map<String, Object> per) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rating", rating);
		String rating_name = (String) per.get("name");

		Random generator = new Random();
		int age = generator.nextInt(15) + 19;
		int height = generator.nextInt(35) + 165;
		int foot = generator.nextInt(10);
		int weight = (int) ((height - 100) * (generator.nextInt(50) + 75) / 100);
		map.put("age", age);
		map.put("height", height);
		map.put("weight", weight);

		if(foot <= 6)
			map.put("foot", "R");
		else
			map.put("foot", "L");
		
		int tend = 0;
		if(position == 0) {
			map.put("position","GK");
		}
		else if(position == 1) {
			map.put("position","DF");
			tend = generator.nextInt(2);
		}
		else if(position == 2) {
			map.put("position","MF");
			tend = generator.nextInt(4);
		}
		else if(position == 3) {
			map.put("position","FW");
			tend = generator.nextInt(2);
		}
		
		String po = (String) map.get("position");
		map.put("name", rating_name + " " + po + " player");
		po = String.valueOf(tend) + "_" + po;
		map.put("position_detail",po);
		Map<String, Integer> stat_tend = loginDAO.getPlayerTendency(po);
		
		int[] grade = new int[4];
		grade[0] = (Integer) per.get("S_grade");
		grade[1] = (Integer) per.get("A_grade") + grade[0];
		grade[2] = (Integer) per.get("B_grade") + grade[1];
		grade[3] = (Integer) per.get("C_grade") + grade[2];
		map.put("key", key);
		int rand = generator.nextInt(grade[3]) + 1;
		int[] stat = new int[23];
		int base_stat = 0;
		if(rand <= grade[0]) {
			base_stat = 60;
			map.put("grade", "S");
		}
		else if(rand <= grade[1]) {
			base_stat = 40;
			map.put("grade", "A");
		}
		else if(rand <= grade[2]) {
			base_stat = 30;
			map.put("grade", "B");
		}
		else if(rand <= grade[3]) {
			base_stat = 20;
			map.put("grade", "C");
		}
		
		int stat_tend_tmp = 0;
		for(int i = 0;i < stat.length;i++) {
			stat_tend_tmp = (int) stat_tend.get("stat"+String.valueOf(i + 1));
			if(stat_tend_tmp >= 150)
				stat[i] = (int) ((base_stat + generator.nextInt(15)) * stat_tend_tmp / 100);
			else if(stat_tend_tmp >= 130)
				stat[i] = (int) ((base_stat + generator.nextInt(10)) * stat_tend_tmp / 100);
			else if(stat_tend_tmp >= 100)
				stat[i] = (int) ((base_stat + generator.nextInt(10) - 10) * stat_tend_tmp / 100);
			else
				stat[i] = (int) ((base_stat + generator.nextInt(10) - 20) * stat_tend_tmp / 100);
		}
		map.put("stat", stat);
		
		loginDAO.makePlayer(map);
	}

	@Override
	public List<Map<String, Object>> getPlayerList(String key) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.getPlayerList(key);
	}

	@Override
	public List<Map<String, Object>> getPlayerOverall(List<Map<String, Object>> list) throws Exception {
		// TODO Auto-generated method stub
		String key = "";
		for(int i = 0;i < list.size();i++) {
			key = (String) list.get(i).get("player_key");
			Object[] overall_fw = new Object[2];
			Object[] overall_mf = new Object[4];
			Object[] overall_df = new Object[2];
			Object[] overall_gk = new Object[1];
			overall_fw[0] = loginDAO.getPlayerOverall("0_FW", key).get("average");
			overall_fw[1] = loginDAO.getPlayerOverall("1_FW", key).get("average");
			overall_mf[0] = loginDAO.getPlayerOverall("0_MF", key).get("average");
			overall_mf[1] = loginDAO.getPlayerOverall("1_MF", key).get("average");
			overall_mf[2] = loginDAO.getPlayerOverall("2_MF", key).get("average");
			overall_mf[3] = loginDAO.getPlayerOverall("3_MF", key).get("average");
			overall_df[0] = loginDAO.getPlayerOverall("0_DF", key).get("average");
			overall_df[1] = loginDAO.getPlayerOverall("1_DF", key).get("average");
			overall_gk[0] = loginDAO.getPlayerOverall("0_GK", key).get("average");
			
			list.get(i).put("stat_fw", overall_fw);
			list.get(i).put("stat_mf", overall_mf);
			list.get(i).put("stat_df", overall_df);
			list.get(i).put("stat_gk", overall_gk);
		}
		return list;
	}

	@Override
	public void removePlayerList(String key) throws Exception {
		// TODO Auto-generated method stub
		loginDAO.removePlayerList(key);
	}

	@Override
	public void saveTeam(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		String team_key = loginDAO.makeTeam(param);
		param.put("team_key", team_key);
		loginDAO.updatePlayers(param);
		loginDAO.updateUserInfo(param);
	}

	@Override
	public void editPlayerName(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		loginDAO.editPlayerName(param);
	}

	@Override
	public Map<String, Object> findUserInfo(Map<String, Object> info) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.findUserInfo(info);
	}

	@Override
	public Map<String, Object> checkId(String id) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.checkId(id);
	}

	@Override
	public void signupAction(Map<String, Object> param) throws Exception {
		// TODO Auto-generated method stub
		loginDAO.signupAction(param);
	}

	@Override
	public Map<String, Object> checkName(String name) throws Exception {
		// TODO Auto-generated method stub
		return loginDAO.checkName(name);
	}
}
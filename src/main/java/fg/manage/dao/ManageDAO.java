package fg.manage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import fg.common.dao.AbstractDAO;

@Repository("manageDAO")
public class ManageDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getPlayerList(String key) {
		// TODO Auto-generated method stub
		return (List<Map<String, Object>>)selectList("manage.getPlayerList", key);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> getPlayerInfoDetail(String key) {
		// TODO Auto-generated method stub
		return (Map<String, Object>)selectOne("manage.getPlayerInfoDetail", key);
	}

	public void saveSelectPosition(List<Map<String, Object>> list) {
		// TODO Auto-generated method stub
		update("manage.saveSelectPosition", list);
	}

	public void resetSelectPosition() {
		// TODO Auto-generated method stub
		update("manage.resetSelectPosition","");
	}

}
package fg.start.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import fg.common.dao.AbstractDAO;

@Repository("startDAO")
public class StartDAO extends AbstractDAO {

	@SuppressWarnings("unchecked")
	public Map<String, Object> getTeamInfo(String key) {
		// TODO Auto-generated method stub
		return (Map<String, Object>) selectOne("start.getTeamInfo",key);
	}

}
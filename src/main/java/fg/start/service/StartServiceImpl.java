package fg.start.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.annotation.Resource;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import fg.start.dao.StartDAO;

@Service("startService")
public class StartServiceImpl implements StartService{
	@Resource(name="startDAO")
    private StartDAO startDAO;
	Logger log = Logger.getLogger(this.getClass());
	@Override
	public Map<String, Object> getTeamInfo(String key) throws Exception {
		// TODO Auto-generated method stub
		return startDAO.getTeamInfo(key);
	}

	
}
package fg.start.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface StartService {

	Map<String, Object> getTeamInfo(String key) throws Exception;
	
}
package fg.manage.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface ManageService {
	List<Map<String, Object>> getPlayerList(String key) throws Exception;
	List<Map<String, Object>> getPlayerOverall(List<Map<String, Object>> list) throws Exception;
	Map<String, Object> getPlayerInfoDetail(String key) throws Exception;
	void saveSelectPosition(List<Map<String, Object>> list) throws Exception;
	void resetSelectPosition() throws Exception;
}
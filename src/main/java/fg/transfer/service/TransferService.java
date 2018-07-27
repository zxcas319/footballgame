package fg.transfer.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public interface TransferService {
	Map<String, Object> getRatingInfo(String key) throws Exception;
	List<Map<String, Object>> makePlayer(Map<String, Object> percent, String key) throws Exception;
	List<Map<String, Object>> getTransferInfo(String key) throws Exception;
	Map<String, Object> getPlayerInfo(String key) throws Exception;
	void dropTempPlayer(int appear) throws Exception;
	void removeTempPlayer() throws Exception;
	void removeTempUserKey(String key) throws Exception;
	void insertTransfer(Map<String, Object> param) throws Exception;
}
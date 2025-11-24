package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TaskDAO {

    public void addTask(int userId, String title, String desc, String deadline, String priority) {
        String sql = "INSERT INTO tasks(user_id, title, description, deadline, priority, status) VALUES(?,?,?,?,?,?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, desc);
            ps.setString(4, deadline);
            ps.setString(5, priority);
            ps.setString(6, "Pending");
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public List<Map<String, String>> getTasks(int userId) {
        List<Map<String, String>> list = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> m = new HashMap<>();
                    m.put("id", rs.getString("id"));
                    m.put("title", rs.getString("title"));
                    m.put("description", rs.getString("description"));
                    m.put("deadline", rs.getString("deadline"));
                    m.put("priority", rs.getString("priority"));
                    m.put("status", rs.getString("status"));
                    list.add(m);
                }
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public void updateTask(int id, String title, String desc, String deadline, String priority, String status) {
        String sql = "UPDATE tasks SET title=?, description=?, deadline=?, priority=?, status=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, title);
            ps.setString(2, desc);
            ps.setString(3, deadline);
            ps.setString(4, priority);
            ps.setString(5, status);
            ps.setInt(6, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void deleteTask(int id) {
        String sql = "DELETE FROM tasks WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    public void toggleTaskStatus(int id) {
        String sql = "UPDATE tasks SET status = CASE WHEN status = 'Completed' THEN 'Pending' ELSE 'Completed' END WHERE id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }
}

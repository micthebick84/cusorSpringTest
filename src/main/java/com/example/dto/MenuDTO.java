package com.example.dto;

import java.util.List;

public class MenuDTO {
    private String menuId;
    private String menuName;
    private String menuType; // "LARGE", "MEDIUM", "SMALL"
    private String parentMenuId;
    private int orderNo;
    private String iconClass;
    private String url;
    private List<MenuDTO> subMenus;
    
    public MenuDTO() {}
    
    public MenuDTO(String menuId, String menuName, String menuType, String parentMenuId, 
                   int orderNo, String iconClass, String url) {
        this.menuId = menuId;
        this.menuName = menuName;
        this.menuType = menuType;
        this.parentMenuId = parentMenuId;
        this.orderNo = orderNo;
        this.iconClass = iconClass;
        this.url = url;
    }
    
    // Getters and Setters
    public String getMenuId() {
        return menuId;
    }
    
    public void setMenuId(String menuId) {
        this.menuId = menuId;
    }
    
    public String getMenuName() {
        return menuName;
    }
    
    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }
    
    public String getMenuType() {
        return menuType;
    }
    
    public void setMenuType(String menuType) {
        this.menuType = menuType;
    }
    
    public String getParentMenuId() {
        return parentMenuId;
    }
    
    public void setParentMenuId(String parentMenuId) {
        this.parentMenuId = parentMenuId;
    }
    
    public int getOrderNo() {
        return orderNo;
    }
    
    public void setOrderNo(int orderNo) {
        this.orderNo = orderNo;
    }
    
    public String getIconClass() {
        return iconClass;
    }
    
    public void setIconClass(String iconClass) {
        this.iconClass = iconClass;
    }
    
    public String getUrl() {
        return url;
    }
    
    public void setUrl(String url) {
        this.url = url;
    }
    
    public List<MenuDTO> getSubMenus() {
        return subMenus;
    }
    
    public void setSubMenus(List<MenuDTO> subMenus) {
        this.subMenus = subMenus;
    }
}

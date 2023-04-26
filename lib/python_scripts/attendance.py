from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
import time

def get_attendance(roll_no, password):
    driver = webdriver.Chrome()
    driver.get("https://automation.vnrvjiet.ac.in/EduPrime3/VNRVJIET")
    UserName = driver.find_element(By.NAME, "UserName")
    Password = driver.find_element(By.NAME, "xPassword")
    UserName.send_keys(roll_no)
    Password.send_keys(password)
    driver.find_element(By.XPATH, "//button[text()='Sign me in']").click()
    time.sleep(5)
    attendence = driver.find_element(By.ID, "attp")
    attendence.click()
    time.sleep(5)
    percent = driver.find_element(By.XPATH, "//h4[@class='font-medium m-b-0']")
    element_text = percent.text
    driver.quit()
    return element_text

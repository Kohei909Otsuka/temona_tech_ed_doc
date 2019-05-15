const clockBtn = document.getElementById('clock');
const timeDisplay = document.getElementById("time");

clockBtn.addEventListener('click', () => {
  timeDisplay.style.color = 'red';
  setInterval(() => {
    const t = new Date();
    const calenderStr = `${t.getFullYear()}-${t.getMonth() + 1}-${t.getDate()}`;
    const timeStr = `${t.getHours()}:${t.getMinutes()}:${t.getSeconds()}`;
    timeDisplay.textContent = calenderStr + ' ' + timeStr;
  }, 1000);
});

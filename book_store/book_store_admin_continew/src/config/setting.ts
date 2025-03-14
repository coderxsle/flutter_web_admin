export const defaultSettings: App.AppSettings = {
  theme: 'light',
  themeColor: '#165DFF',
  tab: true,
  tabMode: 'card-gutter',
  animate: false,
  animateMode: 'zoom-fade',
  menuCollapse: true,
  menuAccordion: true,
  menuDark: false,
  copyrightDisplay: true,
  layout: 'left',
  enableColorWeaknessMode: false,
  enableMourningMode: false,
}
// 根据环境返回配置
export const getSettings = (): App.AppSettings => {
  return defaultSettings
}

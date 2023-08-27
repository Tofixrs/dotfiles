const { Stack, Icon } = ags.Widget;
const { Network } = ags.Service;

export const wiredIndicator = ({
  connecting = Icon("network-wired-acquiring-symbolic"),
  disconnected = Icon("network-wired-disconnected-symbolic"),
  disabled = Icon("network-wired-no-route-symbolic"),
  connected = Icon("network-wired-symbolic"),
  unkown = Icon("content-loading-symbolic")
} = {}) => Stack({
  items: [
    ['unkown', unkown],
    ['disconnected', disconnected],
    ['connected', connected],
    ['disabled', disabled],
    ['connecting', connecting]
  ],
  connections: [[Network, stack => {
    if (!Network.wired) return;

    const { internet } = Network.wired;
    if (internet === 'connected' || internet === 'connecting') return stack.shown = internet;
    
    if (Network.connectivity !== "full") return stack.shown = 'disconnected';

    return stack.shown = 'disabled';
  }]]
})


export const indicator = ({
  wired = wiredIndicator() 
} = {}) => Stack({
  items: [["wired", wired]],
  connections: [[Network, stack => {
      stack.shown = Network.primary || "wired";
  }]]
});

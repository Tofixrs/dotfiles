const { Label } = ags.Widget;
const { execAsync } = ags.Utils;

export const cpuUsage = () => Label({
  className: "cpuusage",
  connections: [[4000, label => {
    execAsync(['bash', '-c', 'echo ""$[100-$(vmstat 1 2|tail -1|awk \'{print $15}\')]"%"']).then(out => {label.label = `  ${out}`});
  }]]
})

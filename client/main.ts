import Axios from 'axios';
import * as cryptojs from 'crypto-js';


let opts = new Map<string, string>();

process.argv.forEach(element => {
  let mch = element.match(/^--([^= ]+)=([^= ]+)$/);
  if (mch) {
    opts.set(mch[1], mch[2]);
  }
})

let currentTime = new Date(Date.now());
let currentTimeStr = currentTime.toISOString().replace(/^(\d\d\d\d)-(\d\d)-(\d\d)T(\d\d:\d\d:\d\d).*$/, "$1/$2/$3 $4");

let auth_data = currentTimeStr + opts.get("secret");
let secret = cryptojs.SHA256(auth_data);

let url:string = opts.get("register") as string;

let prom = Axios.post(
  url,
  JSON.stringify(
  {
    hostname: opts.get("hostname"),
    ip: opts.get("ip"),
    timestamp: currentTimeStr,
    secret: secret
  }),
  {
    headers: { "Content-type": "application/json" }
  }
);

prom.then(response => {
  console.info("Succeed ......................");
}).catch(reason => {
  console.error("Failed ......................");
  console.error(reason);
})

import http from 'k6/http';
import { check } from 'k6';
export const options = {
  vus: 30,
  duration: '30s',
  noCookiesReset: true,
}

export default function () {
  let x = Math.floor((Math.random() * 100) + 1);
  let jar = http.cookieJar();
  const res = http.get(`http://localhost:9000/app/read?id=${x}`);
  check(res, {
	'is status 200': (r) => r.status === 200,
	'response time < 200ms': (r) => r.timings.duration < 200,
  });
}

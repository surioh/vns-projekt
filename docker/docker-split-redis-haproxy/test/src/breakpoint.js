import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
	stages: [
		{ duration: '10s', target: 500 },
		{ duration: '10s', target: 2500 },
		{ duration: '20s', target: 2500 },
		{ duration: '10s', target: 4500 },
		{ duration: '20s', target: 4500 },
		{ duration: '10s', target: 6500 },
		{ duration: '20s', target: 6500 },
		{ duration: '10s', target: 8500 },
		{ duration: '20s', target: 8500 },
		{ duration: '10s', target: 0 },
	],
};

export default function () {
	let x = Math.floor((Math.random() * 100) + 1);
	let res = http.get(`http://localhost:8080/app/read?id=${x}`);
	check(res, {
		'status is 200': (r) => r.status === 200,
		'response time < 150ms': (r) => r.timings.duration <= 150,
	});
	sleep(1);
}

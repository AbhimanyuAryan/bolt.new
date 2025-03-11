import { env } from 'node:process';

export function getAPIKey() {
  return env.OPENAI_API_KEY;
}

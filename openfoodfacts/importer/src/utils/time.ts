export function nowISO(): string {
  return new Date().toISOString();
}

export function formatISO(date: Date): string {
  return date.toISOString();
}

import { Client } from '@notionhq/client';

const notion = new Client({ auth: process.env.NOTION_TOKEN });
const DB_ID = process.env.NOTION_DB_ID!;

const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export default async function handler(req: any, res: any) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');
  if (req.method === 'OPTIONS') return res.status(200).end();
  if (req.method !== 'POST') return res.status(405).json({
    success: false, message: 'Method not allowed'
  });
  const { name, email, company, website } = req.body || {};

  // Honeypot: real users never fill 'website'
  if (website) return res.status(200).json({ success: true });
  if (!name || name.length < 2) return res.status(400).json({
    success: false, message: 'Name is required.'
  });
  if (!email || !EMAIL_RE.test(email)) return res.status(400).json({
    success: false, message: 'A valid email is required.'
  });
  if (!company) return res.status(400).json({
    success: false, message: 'Company is required.'
  });
  try {
    await notion.pages.create({
      parent: { database_id: DB_ID },
      properties: {
        Name:        { title:   [{ text: { content: name } }] },
        Email:       { email },
        Company:     { rich_text: [{ text: { content: company } }] },
        'Submitted At': { date: { start: new Date().toISOString() } },
        Source:      { rich_text: [{ text: { content: 'pricing-webinar' } }] },
        Status:      { select: { name: 'New' } },
      },
    });
    return res.status(200).json({ success: true });
  } catch (err: any) {
    console.error('Notion write failed:', err.message);
    return res.status(500).json({
      success: false, message: 'Could not save your seat. Please try again.'
    });
  }
}

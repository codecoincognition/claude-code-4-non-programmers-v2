import { ImageResponse } from '@vercel/og';
import { writeFileSync } from 'fs';

const HEADLINE = 'Pricing for SaaS founders';
const SUB = 'A free 60-minute workshop. Live, with Q&A.';

const png = await new ImageResponse(
  {
    type: 'div',
    props: {
      style: {
        width: '100%',
        height: '100%',
        display: 'flex',
        flexDirection: 'column',
        justifyContent: 'center',
        padding: '80px',
        background: '#fff',
        color: '#111',
        fontFamily: 'Inter, system-ui, sans-serif',
      },
      children: [
        {
          type: 'div',
          props: {
            style: { fontSize: 72, fontWeight: 700, lineHeight: 1.1 },
            children: HEADLINE,
          },
        },
        {
          type: 'div',
          props: {
            style: { fontSize: 32, marginTop: 32, color: '#666' },
            children: SUB,
          },
        },
        {
          type: 'div',
          props: {
            style: { fontSize: 28, marginTop: 48, color: '#2c5cdb', fontWeight: 600 },
            children: 'Save my seat →',
          },
        },
      ],
    },
  },
  { width: 1200, height: 630 }
).arrayBuffer();

writeFileSync('public/og.png', Buffer.from(png));
console.log('og.png written.');

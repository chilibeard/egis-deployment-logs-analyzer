export const metadata = {
  title: 'Egis Deployment Log Analyzer',
  description: 'Analyze Intune and Autopilot deployment logs'
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <head>
        <title>Egis Deployment Log Analyzer</title>
      </head>
      <body>
        {children}
      </body>
    </html>
  );
} 
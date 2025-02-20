"use client";

import { useEffect, useState } from 'react';

export default function Home() {
  const [deployments, setDeployments] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => {
    async function fetchDeployments() {
      try {
        // Update the backend URL if needed (for local testing, it could be http://localhost:3000/deployments)
        const res = await fetch('http://localhost:3000/deployments');
        if (!res.ok) {
          throw new Error('Failed to fetch deployments');
        }
        const data = await res.json();
        setDeployments(data);
      } catch (err) {
        setError(err.message);
        console.error(err);
      }
    }
    fetchDeployments();
  }, []);

  return (
    <main style={{ padding: "2rem", fontFamily: "sans-serif" }}>
      <h1>Welcome to the Egis Deployment Log Analyzer</h1>
      <h2>Deployments Dashboard</h2>
      {error ? (
        <p style={{ color: 'red' }}>Error: {error}</p>
      ) : deployments.length > 0 ? (
        <ul>
          {deployments.map((d) => (
            <li key={d.id}>
              {d.machineName} - {d.status} - {new Date(d.createdAt).toLocaleString()}
            </li>
          ))}
        </ul>
      ) : (
        <p>No deployments found.</p>
      )}
    </main>
  );
} 
"use client"; // Mark file as a Client Component

import { useEffect, useState } from 'react';

export default function Home() {
  const [deployments, setDeployments] = useState([]);
  const [error, setError] = useState(null);
  const [isLoading, setIsLoading] = useState(true); // Added loading state

  useEffect(() => {
    async function fetchDeployments() {
      try {
        // Use a relative URL so that requests are routed to the backend rewrite
        const res = await fetch(`/deployments`);
        if (!res.ok) {
          throw new Error('Failed to fetch deployments');
        }
        const data = await res.json();
        setDeployments(data);
      } catch (err) {
        setError(err.message);
        console.error(err);
      } finally {
        setIsLoading(false); // Stop loading regardless of outcome
      }
    }
    fetchDeployments();
  }, []);

  return (
    <main style={{ padding: "2rem", fontFamily: "sans-serif" }}>
      <h1>Welcome to the Egis Deployment Log Analyzer</h1>
      <h2>Deployments Dashboard</h2>
      {isLoading ? (
        <p>Loading deployments...</p>
      ) : error ? (
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
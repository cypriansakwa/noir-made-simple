

\begin{frame}[t]\vspace{2pt}
	\subsection{Password Verification}
	\textbf{Explanation:} \\
	Most systems store hashes of passwords, not the passwords themselves. In zero-knowledge, you can prove you know a password that matches a given hash, without revealing the password.
	
	\vspace{1em}
	\textbf{Noir Example:}
	\begin{lstlisting}[language=Rust]
		fn main(password: [u8; N], public_hash: Field) {
			let computed_hash = poseidon_hash(password);
			assert(computed_hash == public_hash);
		}
	\end{lstlisting}
	
	\textbf{Use cases:}
	\begin{itemize}
		\item Anonymous authentication
		\item Proving credentials without risk of leaks
	\end{itemize}
\end{frame}

\begin{frame}[t]\vspace{2pt}
	\subsection{Practical Example – Age Verification Circuit}
	\textbf{Explanation:} \\
	Let’s put this into practice: \\
	Suppose a website needs to verify users are over 18. With zero-knowledge, users prove their age meets the requirement, while keeping their actual age secret.
	
	\vspace{1em}
	\textbf{Noir Circuit Example:}
	\begin{lstlisting}[language=Rust]
		fn main(age: u8) {
			assert(age >= 18);
		}
	\end{lstlisting}
	
	\textbf{Applications:}
	\begin{itemize}
		\item Online gaming
		\item Alcohol or tobacco sales
		\item Social media restrictions
	\end{itemize}
\end{frame}

\begin{frame}[t]\vspace{2pt}
	\subsection{Why Use ZKP Patterns?}
	\textbf{Explanation:} \\
	Zero-Knowledge Proofs provide privacy, security, and trust:
	\begin{itemize}
		\item \textbf{Privacy:} Users do not expose sensitive information.
		\item \textbf{Security:} Systems remain robust against leaks and impersonation.
		\item \textbf{Trustless Verification:} You can verify claims without needing to trust the other party.
	\end{itemize}
	
	\textbf{Challenges:}
	\begin{itemize}
		\item Designing circuits can be complex.
		\item Performance: Larger sets and ranges may require more computational resources.
		\item Usability: Users and developers must understand how to encode secrets and verify proofs.
	\end{itemize}
\end{frame}

\begin{frame}[t]\vspace{2pt}
	\subsection{Hands-On Noir Exercise}
	\textbf{Explanation:} \\
	Let’s practice with set membership. \\
	Write a Noir circuit that proves a secret number is in \texttt{[5, 10, 15, 20]}. \\
	The user provides a secret number; the proof will verify membership without revealing which number was chosen.
	
	\vspace{1em}
	\textbf{Starter Code:}
	\begin{lstlisting}[language=Rust]
		fn main(secret: u8) {
			let set: [u8; 4] = [5, 10, 15, 20];
			let mut in_set = false;
			for i in 0..4 {
				in_set = in_set || (secret == set[i]);
			}
			assert(in_set);
		}
	\end{lstlisting}
	
	\textbf{Discussion:}
	\begin{itemize}
		\item How would you modify this to prove the number is \textbf{not} in the set?
		\item Try changing the set values or the range, and see how the circuit behaves.
	\end{itemize}
\end{frame}

\begin{frame}[t]\vspace{2pt}
	\subsection{Further Exploration}
	\textbf{Explanation:} \\
	Zero-Knowledge Proofs offer many possibilities:
	\begin{itemize}
		\item \textbf{Multi-attribute proofs:} Prove multiple facts at once, e.g. age > 18 \textbf{and} country == "Kenya".
		\item \textbf{Combining patterns:} Use hashes with set membership or ranges for more complex proofs.
		\item \textbf{Blockchain privacy:} Prove transaction validity without revealing amounts or parties.
	\end{itemize}
	
	\textbf{Resources:}
	\begin{itemize}
		\item \href{https://noir-lang.org/docs/}{Noir Documentation} – Official Noir language docs.
		\item \href{https://zklearning.org/}{zkLearning} – Interactive ZKP tutorials.
		\item \href{https://vitalik.ca/general/2017/06/22/zero_knowledge.html}{Vitalik Buterin on Zero-Knowledge} – Real-world insights and examples.
	\end{itemize}
\end{frame}

\begin{frame}[t]\vspace{2pt}
	\subsection{Q\&A and Discussion}
	\textbf{Explanation:} \\
	Encourage learners to think about:
	\begin{itemize}
		\item Where can these patterns improve privacy in real-life applications?
		\item What privacy risks do ZKPs solve in financial, medical, or social contexts?
		\item How could you combine multiple zero-knowledge patterns to build powerful, private systems?
	\end{itemize}
	
	Invite questions about designing Noir circuits, encoding secrets, and practical deployment.
\end{frame}
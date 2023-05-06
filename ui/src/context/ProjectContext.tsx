import { createContext, ReactNode, useCallback, useState } from 'react';
import { Project } from '../model/project';

type ProjectcontextType = {
  project: Project | undefined;
  setProjectOrUndefined: (newProject: Project | undefined) => void;
};

const ProjectContext = createContext<ProjectcontextType>({
  project: undefined,
  setProjectOrUndefined: () => {}
});

interface Props {
  children: ReactNode;
}

export function ProjectProvider({ children }: Props) {
  const [project, setProject] = useState<Project | undefined>(undefined);

  const setProjectOrUndefined = useCallback(
    (newProject: Project | undefined) => {
      setProject(newProject);
    },
    [setProject]
  );

  return (
    <ProjectContext.Provider value={{ project, setProjectOrUndefined }}>
      {children}
    </ProjectContext.Provider>
  );
}

export default ProjectContext;

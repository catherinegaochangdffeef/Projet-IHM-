program tp_projet;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, u_gabarit, u_select_inscrit, u_list_inscrit, 
u_detail_inscrit, u_releve_list, u_modele
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(Tf_gabarit, f_gabarit);
  Application.CreateForm(Tf_select_inscrit, f_select_inscrit);
  Application.CreateForm(Tf_list_inscrit, f_list_inscrit);
  Application.CreateForm(Tf_detail_inscrit, f_detail_inscrit);
  Application.CreateForm(Tf_releve_list, f_releve_list);
  Application.Run;
end.


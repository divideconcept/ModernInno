[Code]
{ from https://stackoverflow.com/questions/11778292/how-to-change-wizard-size-width-and-height-in-an-inno-setup-installer }
procedure ShiftDown(Control: TControl; DeltaY: Integer);
begin
  Control.Top := Control.Top + DeltaY;
end;

procedure ShiftRight(Control: TControl; DeltaX: Integer);
begin
  Control.Left := Control.Left + DeltaX;
end;

procedure ShiftDownAndRight(Control: TControl; DeltaX, DeltaY: Integer);
begin
  ShiftDown(Control, DeltaY);
  ShiftRight(Control, DeltaX);
end;

procedure GrowDown(Control: TControl; DeltaY: Integer);
begin
  Control.Height := Control.Height + DeltaY;
end;

procedure GrowRight(Control: TControl; DeltaX: Integer);
begin
  Control.Width := Control.Width + DeltaX;
end;

procedure GrowRightAndDown(Control: TControl; DeltaX, DeltaY: Integer);
begin
  GrowRight(Control, DeltaX);
  GrowDown(Control, DeltaY);
end;

procedure GrowRightAndShiftDown(Control: TControl; DeltaX, DeltaY: Integer);
begin
  GrowRight(Control, DeltaX);
  ShiftDown(Control, DeltaY);
end;

{ inspired by https://stackoverflow.com/questions/11778292/how-to-change-wizard-size-width-and-height-in-an-inno-setup-installer
  and https://stackoverflow.com/questions/38684039/display-image-in-top-panel-of-inno-setup-wizard-instead-of-page-title-and-descri }
procedure InitializeWizard();
var
  DeltaY: Integer;
  DeltaX: Integer;
begin
  with WizardForm do
  begin
    DeltaX := ScaleX(WizardSmallBitmapImage.Bitmap.Width)-MainPanel.Width;
    DeltaY := ScaleY(WizardSmallBitmapImage.Bitmap.Height)-MainPanel.Height;
    
    { Banner }
    MainPanel.Width := ScaleX(WizardSmallBitmapImage.Bitmap.Width);
    MainPanel.Height := ScaleY(WizardSmallBitmapImage.Bitmap.Height);
    WizardSmallBitmapImage.Top := 0;
    WizardSmallBitmapImage.Left := 0;
    WizardSmallBitmapImage.Width := MainPanel.Width;
    WizardSmallBitmapImage.Height := MainPanel.Height;
    WizardSmallBitmapImage.Stretch := True;
    WizardSmallBitmapImage.AutoSize := False;
    PageDescriptionLabel.Visible := False;
    PageNameLabel.Visible := False;
    Bevel1.Visible := False;

    { Frame }
    GrowRightAndDown(WizardForm, DeltaX, DeltaY);

    { General Controls }
    GrowRightAndShiftDown(Bevel, DeltaX, DeltaY);
    ShiftDownAndRight(CancelButton, DeltaX, DeltaY);
    ShiftDownAndRight(NextButton, DeltaX, DeltaY);
    ShiftDownAndRight(BackButton, DeltaX, DeltaY);
    GrowRightAndDown(OuterNotebook, DeltaX, DeltaY);
    GrowRight(BeveledLabel, DeltaX);
    
    { InnerPage }
    GrowRightAndDown(InnerNotebook, DeltaX, DeltaY);

    { WelcomePage }
    WelcomeLabel2.Top := WelcomeLabel2.Top+MainPanel.Height;
    WelcomeLabel2.Left := ScaleX(20);
    WelcomeLabel2.Width :=  MainPanel.Width-ScaleX(20);
    WelcomeLabel1.Top := WelcomeLabel1.Top+MainPanel.Height;
    WelcomeLabel1.Left := ScaleX(10);
    WelcomeLabel1.Width :=  MainPanel.Width-ScaleX(10);
    WizardBitmapImage.Bitmap := WizardSmallBitmapImage.Bitmap;
    WizardBitmapImage.Width := MainPanel.Width;
    WizardBitmapImage.Height := MainPanel.Height;

    { LicensePage }
    ShiftDown(LicenseNotAcceptedRadio, DeltaY);
    ShiftDown(LicenseAcceptedRadio, DeltaY);
    GrowRightAndShiftDown(LicenseMemo, DeltaX, DeltaY);
    GrowRightAndShiftDown(LicenseLabel1, DeltaX, DeltaY);

    { SelectDirPage }
    GrowRightAndShiftDown(DiskSpaceLabel, DeltaX, DeltaY);
    ShiftDownAndRight(DirBrowseButton, DeltaX, DeltaY);
    GrowRightAndShiftDown(DirEdit, DeltaX, DeltaY);
    GrowRightAndShiftDown(SelectDirBrowseLabel, DeltaX, DeltaY);
    GrowRightAndShiftDown(SelectDirLabel, DeltaX, DeltaY);

    { SelectComponentsPage }
    GrowRightAndShiftDown(ComponentsDiskSpaceLabel, DeltaX, DeltaY);
    GrowRightAndShiftDown(ComponentsList, DeltaX, DeltaY);
    GrowRightAndShiftDown(TypesCombo, DeltaX, DeltaY);
    GrowRightAndShiftDown(SelectComponentsLabel, DeltaX, DeltaY);

    { SelectTasksPage }
    GrowRightAndShiftDown(TasksList, DeltaX, DeltaY);
    GrowRightAndShiftDown(SelectTasksLabel, DeltaX, DeltaY);

    { ReadyPage }
    GrowRightAndShiftDown(ReadyMemo, DeltaX, DeltaY);
    GrowRightAndShiftDown(ReadyLabel, DeltaX, DeltaY);

    { InstallingPage }
    GrowRightAndShiftDown(FilenameLabel, DeltaX, DeltaY);
    GrowRightAndShiftDown(StatusLabel, DeltaX, DeltaY);
    GrowRightAndShiftDown(ProgressGauge, DeltaX, DeltaY);

    { FinishedPage }
    FinishedLabel.Top := FinishedLabel.Top+MainPanel.Height;
    FinishedLabel.Left := ScaleX(20);
    FinishedLabel.Width :=  MainPanel.Width-ScaleX(20);
    FinishedHeadingLabel.Top := FinishedHeadingLabel.Top+MainPanel.Height;
    FinishedHeadingLabel.Left := ScaleX(10);
    FinishedHeadingLabel.Width :=  MainPanel.Width-ScaleX(10);
    WizardBitmapImage2.Bitmap := WizardSmallBitmapImage.Bitmap;
    WizardBitmapImage2.Width := MainPanel.Width;
    WizardBitmapImage2.Height := MainPanel.Height;
  end;
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpSelectTasks then
    WizardForm.NextButton.Caption := SetupMessage(msgButtonInstall);
end;

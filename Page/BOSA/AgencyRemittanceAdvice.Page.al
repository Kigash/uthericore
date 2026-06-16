page 50338 "Agency Remittance Advice"
{
    // version TL2.0

    Editable = false;
    PageType = Card;
    SourceTable = "Agency Remittance Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Agent Code"; Rec."Agent Code")
                {
                    ApplicationArea = All;
                }
                field("Agent Name"; Rec."Agent Name")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created Date"; Rec."Created Date")
                {
                    ApplicationArea = All;
                }
                field("Created Time"; Rec."Created Time")
                {
                    ApplicationArea = All;
                }
                field("Period Month"; Rec."Period Month")
                {
                    ApplicationArea = All;
                }
                field("Period Year"; Rec."Period Year")
                {
                    ApplicationArea = All;
                }
                field("Total Expected Amount"; Rec."Total Expected Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Actual Amount"; Rec."Total Actual Amount")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }
            part(Page; 50339)
            {
                ApplicationArea = All;
                SubPageLink = "Document No." = FIELD("No.");
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Export to Exel")
            {
                Image = ExportToExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsExportVisible;
                ApplicationArea = All;
                trigger OnAction()
                var
                    TempFile: File;
                    FileName: Text[250];
                    IStream: InStream;
                    ToFile: Text[250];
                begin
                    CLEAR(ExportAgencyRemittanceAdvice);
                    ExportAgencyRemittanceAdvice.SetDocumentNo(Rec."No.");
                    TempFile.TEXTMODE(FALSE);
                    TempFile.WRITEMODE(TRUE);
                    FileName := 'C:\Temp\TempReport.xls';
                    TempFile.CREATE(FileName);
                    TempFile.CLOSE;

                    ExportAgencyRemittanceAdvice.SAVEASEXCEL(FileName);
                    TempFile.OPEN(FileName);
                    TempFile.CREATEINSTREAM(IStream);
                    ToFile := Rec."No." + '.xls';
                    DOWNLOADFROMSTREAM(IStream, 'Save file to client', '', 'Excel File *.xls| *.xls', ToFile);
                    TempFile.CLOSE();

                    Rec.Status := Rec.Status::Exported;
                    Rec.MODIFY;
                end;
            }
            action("Import from Excel")
            {
                Image = ImportExcel;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsImportVisible;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CLEAR(ImportRemittanceAdvice);
                    ImportRemittanceAdvice.RUN;
                end;
            }
            action("Push to Server")
            {
                Image = ExportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsPushToServerVisible;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    MESSAGE('Later');
                end;
            }
            action("Pull from Server")
            {
                Image = ImportDatabase;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsPullfromServer;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    MESSAGE('Later');
                end;
            }
            action(Post)
            {
                Image = Post;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Visible = IsPostVisible;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    BOSAManagement.PostAgencyRemittance(Rec);
                end;
            }
        }
        area(reporting)
        {
            action(Print)
            {
                Image = BankAccountStatement;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    AgencyRemittanceHeader.GET(Rec."No.");
                    AgencyRemittanceHeader.SETRECFILTER;
                    REPORT.RUN(REPORT::"Agency Remittance Advice", TRUE, FALSE, AgencyRemittanceHeader);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        PageVisibility;
        PageEditable;
    end;

    var
        ExportAgencyRemittanceAdvice: Report "Export Agency Rem. Advice";
        FileName: Text[50];
        ImportRemittanceAdvice: Report "Import Remittance Advice";
        IsExportVisible: Boolean;
        IsImportVisible: Boolean;
        IsPostVisible: Boolean;
        IsPushtoServerVisible: Boolean;
        IsPullfromServer: Boolean;
        BOSAManagement: Codeunit "BOSA Management";
        AgencyRemittanceHeader: Record "Agency Remittance Header";

    local procedure PageVisibility()
    begin
        IF Rec.Status = Rec.Status::New THEN BEGIN
            IsExportVisible := TRUE;
            IsImportVisible := FALSE;
            IsPostVisible := FALSE;
            IsPushtoServerVisible := TRUE;
            IsPullfromServer := FALSE;
        END;
        IF Rec.Status = Rec.Status::Exported THEN BEGIN
            IsExportVisible := FALSE;
            IsImportVisible := TRUE;
            IsPostVisible := FALSE;
            IsPushtoServerVisible := FALSE;
            IsPullfromServer := TRUE;
        END;
        IF Rec.Status = Rec.Status::Imported THEN BEGIN
            IsExportVisible := FALSE;
            IsImportVisible := FALSE;
            IsPostVisible := TRUE;
            IsPushtoServerVisible := FALSE;
            IsPullfromServer := FALSE;
        END;
        IF Rec.Status = Rec.Status::Posted THEN BEGIN
            IsExportVisible := FALSE;
            IsImportVisible := FALSE;
            IsPostVisible := FALSE;
            IsPushtoServerVisible := FALSE;
            IsPullfromServer := FALSE;
        END
    end;

    local procedure PageEditable()
    begin
        IF Rec.Status = Rec.Status::New THEN
            CurrPage.EDITABLE := TRUE
        ELSE
            CurrPage.EDITABLE := FALSE;
    end;
}


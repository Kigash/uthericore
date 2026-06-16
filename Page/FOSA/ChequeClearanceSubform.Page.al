page 50161 "Cheque Clearance Subform"
{
    // version CTS2.0

    AutoSplitKey = true;
    DeleteAllowed = false;
    PageType = ListPart;
    RefreshOnActivate = true;
    SourceTable = "Cheque Clearance Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ApplicationArea = All;
                }
                field("Sort Code"; Rec."Sort Code")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field("Voucher Type"; Rec."Voucher Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Processing Date"; Rec."Processing Date")
                {
                    ApplicationArea = All;
                    Importance = Additional;
                }

                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Indicator; Rec.Indicator)
                {
                    ApplicationArea = All;
                }
                field("Unpaid Reason"; Rec."Unpaid Reason")
                {
                    ApplicationArea = All;
                }
                field("Unpaid Code"; Rec."Unpaid Code")
                {
                    ApplicationArea = All;
                }
                field(Validated; Rec.Validated)
                {
                    ApplicationArea = All;
                }
                field("Presenting Bank"; Rec."Presenting Bank")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field(Session; Rec.Session)
                {
                    ApplicationArea = All;
                }
                field("Bank No."; Rec."Bank No.")
                {
                    ApplicationArea = All;
                }
                field("Branch No."; Rec."Branch No.")
                {
                    ApplicationArea = All;
                }
                field("Sacco Account No."; Rec."Sacco Account No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import PRM File")
            {
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CLEAR(ImportPRMFile);
                    ChequeClearanceHeader.GET(Rec."Document No.");
                    ChequeClearanceHeader.TESTFIELD(Status, ChequeClearanceHeader.Status::New);
                    ImportPRMFile.SetDocumentNo(ChequeClearanceHeader."No.");
                    ImportPRMFile.RUN;
                end;
            }
            action("Validate PRM File")
            {
                Image = ValidateEmailLoggingSetup;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin

                    ChequeClearanceHeader.GET(Rec."Document No.");
                    ChequeClearanceHeader.TESTFIELD(Status, ChequeClearanceHeader.Status::New);
                    IF CONFIRM(ConfirmValidatePRMMsg, TRUE) THEN BEGIN
                        IF NOT Rec.LinesExist(Rec."Document No.") THEN
                            ERROR(NoLinesExistErr);

                        FOSAManagement.ValidatePRMEntry(ChequeClearanceHeader);
                    END;
                end;
            }
            action("Export PRM File")
            {
                Image = Export1099;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;

                trigger OnAction()
                begin
                    ChequeClearanceHeader.GET(Rec."Document No.");
                    ChequeClearanceHeader.TESTFIELD(Status, ChequeClearanceHeader.Status::Approved);
                    ChequeClearanceHeader.TESTFIELD(Posted, TRUE);
                    IF NOT Rec.LinesExist(Rec."Document No.") THEN
                        ERROR(NoLinesExistErr);
                    IF Rec.LinesNotValidated(Rec."Document No.") THEN
                        ERROR(NotValidatedErr);

                    CLEAR(ExportPRMFile);
                    ExportPRMFile.SetDocumentNo(Rec."Document No.");
                    ExportPRMFile.RUN;
                end;
            }
        }
    }

    var
        i: Integer;
        LineNo: Integer;
        ImportPRMFile: XMLport "Import PRM File";
        ExportPRMFile: XMLport "Export PRM File";
        ChequeClearanceHeader: Record "Cheque Clearance Header";
        IsVisibleExportPRMFile: Boolean;
        IsVisibleImportPRMFile: Boolean;
        FOSAManagement: Codeunit "FOSA Management";
        ConfirmValidatePRMMsg: Label 'Do you want to the validate PRM entries?';
        NoLinesExistErr: Label 'No PRM Entries Exist';
        NotValidatedErr: Label 'PRM Entries have not been validated';
}



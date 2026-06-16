page 50661 "Checkoff Subform"
{
    // version TL2.0

    PageType = ListPart;
    SourceTable = "Checkoff Line";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;

                }
                field("Reference Code"; Rec."Reference Code")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;

                }
                field("Account Name"; Rec."Account Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Account Balance"; Rec."Account Balance")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                    begin
                        CurrPage.Update()
                    end;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Import Checkoff File")
            {
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CLEAR(ImportCheckoffFile);
                    CheckoffHeader.GET(Rec."Document No.");
                    CheckoffHeader.TESTFIELD(Status, CheckoffHeader.Status::New);
                    ImportCheckoffFile.SetDocumentNo(CheckoffHeader."No.");
                    ImportCheckoffFile.RUN;
                end;
            }
            action("Validate Lines")
            {
                Image = ImportCodes;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CheckoffHeader.GET(Rec."Document No.");
                    CashManagement.ValidateCheckoffLines(CheckoffHeader);
                end;
            }

        }
    }

    trigger OnAfterGetRecord();
    begin

    end;

    var
        //PaymentRemittanceAdvise : Report "50441";
        CashManagement: Codeunit "Cash Management";
        ImportCheckoffFile: XmlPort "Import Checkoff File";
        CheckoffHeader: Record "Checkoff Header";
}


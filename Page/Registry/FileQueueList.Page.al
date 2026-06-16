page 50970 "File Queue"
{
    // version TL2.0

    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    PageType = List;
    SourceTable = "Transfer Files Line";
    SourceTableView = WHERE(Returned = filter('No'),
                            "SentRet Note" = filter('No'));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transfer ID"; Rec."Transfer ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("File Number"; Rec."File Number")
                {
                    ApplicationArea = All;
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field("Member No"; Rec."Member No")
                {
                    ApplicationArea = All;
                }
                field("ID No"; Rec."ID No")
                {
                    ApplicationArea = All;
                }
                field("Payroll No"; Rec."Payroll No")
                {
                    ApplicationArea = All;
                }
                field("File Volume"; Rec."File Volume")
                {
                    ApplicationArea = All;
                }
                field("Time Received"; Rec."Time Received")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleText;
                }
                field(sentreturnnote; sentreturnnote)
                {
                    ApplicationArea = All;
                    Caption = 'sentreturnnote';
                }
                field("SentRet Note"; Rec."SentRet Note")
                {
                    ApplicationArea = All;
                }
                field("File No"; Rec."File No")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action("Send Return Note")
            {
                Image = Note;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    RegistryManagement.SendReturnNote(Rec);
                end;
            }
            action("Transfer File")
            {
                Image = BOM;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction();
                begin
                    CurrPage.SETSELECTIONFILTER(Rec);
                    RegistryManagement.TransferFile(Rec);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF CURRENTDATETIME > Rec."Due Date" THEN BEGIN
            StyleText := 'Unfavorable';
        END;
    end;

    trigger OnOpenPage();
    begin
        User.GET(USERID);
        Rec.FILTERGROUP(2);
        Rec.SETRANGE("Received By", USERID);
        Rec.SETRANGE("SentRet Note", FALSE);
        Rec.FILTERGROUP(0);
    end;

    var
        User: Record "User Setup";
        Overdue: Boolean;
        StyleText: Text[20];
        FileReturn: Record "File Return";
        TransferFilesLines: Record "Transfer Files Line";
        NoSetup: Record "Registry SetUp";
        NoSeriesMgt: Codeunit "No. Series";sentreturnnote: Boolean;
        TransferRegistryFiles: Record "Transfer Registry File";
        TransferFilesLines2: Record "Transfer Files Line";
        RegistryManagement: Codeunit "Registry Management2";
}


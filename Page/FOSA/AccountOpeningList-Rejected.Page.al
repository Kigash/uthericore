page 50022 "Account Opening List-Rejected"
{
    // version TL2.0

    Caption = 'Approved Account Openings';
    CardPageID = "Account Opening Card";
    Editable = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Related Information,Approval Request,Comments,Category 7,Category 8';
    SourceTable = "Account Opening";
    SourceTableView = WHERE(Status = FILTER(Approved));

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; Rec."Account Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Member No."; Rec."Member No.")
                {
                    ApplicationArea = All;
                }
                field("Member Name"; Rec."Member Name")
                {
                    ApplicationArea = All;
                }
                field("Account No."; Rec."Account No.")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
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
                field("Approved Time"; Rec."Approved Time")
                {
                    ApplicationArea = All;
                }
                field("Approved Date"; Rec."Approved Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ApplicationArea = All;
                }
                field("Last Modified Time"; Rec."Last Modified Time")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By"; Rec."Last Modified By")
                {
                    ApplicationArea = All;
                }
                field("Created By Host IP"; Rec."Created By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Approved By Host IP"; Rec."Approved By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Created By Host Name"; Rec."Created By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Created By Host MAC"; Rec."Created By Host MAC")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By Host IP"; Rec."Last Modified By Host IP")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By Host Name"; Rec."Last Modified By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Last Modified By Host MAC"; Rec."Last Modified By Host MAC")
                {
                    ApplicationArea = All;
                }
                field("Approved By Host Name"; Rec."Approved By Host Name")
                {
                    ApplicationArea = All;
                }
                field("Approved By Host MAC"; Rec."Approved By Host MAC")
                {
                    ApplicationArea = All;
                }
                field("Branch Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {

            action(Comments)
            {
                Caption = 'Comments';
                Image = ViewComments;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                Scope = Repeater;
                ToolTip = 'View or add comments for the record.';

                trigger OnAction()
                var
                    //ApprovalsMgmt: Codeunit "1535";
                    RecRef: RecordRef;
                begin
                    ApprovalCommentLine.FILTERGROUP(10);
                    ApprovalCommentLine.SETRANGE("Document No.", Rec."No.");
                    ApprovalCommentLine.FILTERGROUP(0);
                    ApprovalComments.SETTABLEVIEW(ApprovalCommentLine);
                    ApprovalComments.EDITABLE(FALSE);
                    ApprovalComments.RUN;
                end;
            }
        }
    }

    var
        ApprovalCommentLine: Record "Approval Comment Line";
        ApprovalComments: Page "Approval Comments";

}


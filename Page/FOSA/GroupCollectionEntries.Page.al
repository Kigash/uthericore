page 55033 "Group Collection Entries"
{
    // version MC2.0

    Caption = 'Group Collections';
    DeleteAllowed = false;
    // InsertAllowed = false;
    PageType = List;
    PromotedActionCategories = 'New,Process,Reports,Approval Request,Allocation,Posting,Category7';
    SourceTable = "Group Collection Entry";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Transaction No."; Rec."Transaction No.")
                {
                    ApplicationArea = All;
                }
                field("Transaction Date"; Rec."Transaction Date")
                {
                    ApplicationArea = All;
                }
                field("Transaction Time"; Rec."Transaction Time")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
                field("Sender Name"; Rec."Sender Name")
                {
                    ApplicationArea = All;
                }
                field("Group Paybill Code"; Rec."Group Paybill Code")
                {
                    ApplicationArea = All;
                }
                field("Group No."; Rec."Group No.")
                {
                    ApplicationArea = All;
                }
                field("Loan Officer ID"; Rec."Loan Officer ID")
                {
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;
                }
                field("Deposited Amount"; Rec."Deposited Amount")
                {
                    ApplicationArea = All;
                }
                field("Allocated Amount"; Rec."Allocated Amount")
                {
                    ApplicationArea = All;
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = All;
                }
                field("Debit Account Code"; Rec."Debit Account Code")
                {
                    ApplicationArea = All;
                }
                field("Posting Status"; Rec."Posting Status")
                {
                    ApplicationArea = All;
                }
                field("Posting Message"; Rec."Posting Message")
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
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Ellipsis = true;
                Image = PostApplication;
                Promoted = true;
                PromotedCategory = Category6;
                PromotedIsBig = true;
                PromotedOnly = true;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                begin
                    Rec.TestField("Posting Status", Rec."Posting Status"::Fail);
                    MicroCreditManagement.PostGroupCollectionEntry(Rec);
                end;
            }
            action(Print)
            {
                Image = Print;
                Promoted = true;
                PromotedCategory = "Report";
                PromotedIsBig = true;
                PromotedOnly = true;

                trigger OnAction()
                begin
                    REPORT.RUN(55004, TRUE, FALSE, Rec);
                end;
            }
            action("Update Collection Entries")
            {

                trigger OnAction()
                begin
                    EVALUATE(CutOffDate, '110819');
                    GroupCollectionEntry.RESET;
                    GroupCollectionEntry.SETRANGE("Posting Status", GroupCollectionEntry."Posting Status"::Success);
                    GroupCollectionEntry.SETRANGE("Transaction Date", 0D, CutOffDate);
                    IF GroupCollectionEntry.FINDSET THEN BEGIN
                        REPEAT
                            GroupCollectionEntry."Allocated Amount" := GroupCollectionEntry."Deposited Amount";
                            GroupCollectionEntry."Remaining Amount" := 0;
                            GroupCollectionEntry.MODIFY(TRUE);
                        UNTIL GroupCollectionEntry.NEXT = 0;
                        MESSAGE('success');
                    END;
                end;
            }
        }
    }

    var
        GroupAllocation: Record "Group Member Allocation";
        MicroCreditManagement: Codeunit "MicroCredit Management";
        GroupCollectionEntry: Record "Group Collection Entry";
        CutOffDate: Date;
}

